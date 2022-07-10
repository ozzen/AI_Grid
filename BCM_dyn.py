import pandas as pd
from torchdyn.utils import *
import pytorch_lightning as pl
import torch.utils.data as data
from torchdyn.core import NeuralODE
from torch.utils.data import Dataset,DataLoader
from torchdyn.nn import DataControl, DepthCat, Augmenter, GalLinear, Fourier

device = torch.device('cpu')

class TraceDataset(Dataset):
    """ Dataset for loading traces"""

    def __init__(self, csv_file):
        self.tracedf = pd.read_csv(csv_file)
        self.tracedf = self.tracedf.apply(lambda x: x * 500000)
        tempx = self.tracedf[["I_mg_d", "I_mg_q", "Id2", "Iq2", "VBat2ds", "VBat2qs", "V_mg_d", "V_mg_q", "Vd2", "Vq2"]]
        self.x = torch.tensor(tempx.values).float().to(device)
        self.y = torch.tensor(self.tracedf[["I_mg_d", "I_mg_q"]].values).float().to(device)
        self.t = torch.tensor(np.linspace(0, 1, len(self.tracedf))).float().squeeze().to(device)

    def __len__(self):
        return len(self.tracedf)

    def __getitem__(self, idx):
        # tempx = torch.from_numpy(self.x.iloc[[idx]].to_numpy()).float()
        # tempx = tempx.squeeze()
        # tempy = torch.from_numpy(self.y.iloc[[idx]].to_numpy()).float()
        # tempy = tempy.squeeze()
        # tempt = torch.from_numpy(self.t.iloc[[idx]].to_numpy()).float()
        sample = {'x': self.x[idx, :], 'y': self.y[idx, :], 't': self.t[idx]}
        return sample

td = TraceDataset('Test_trace.csv')

X_train = td.x
y_train = td.y
train = data.TensorDataset(X_train, y_train)
trainloader = data.DataLoader(train, batch_size=500, shuffle=True)

class Learner(pl.LightningModule):
    def __init__(self, t_span: torch.Tensor, model: nn.Module):
        super().__init__()
        self.model, self.t_span = model, t_span

    def forward(self, x):
        return self.model(x)

    def training_step(self, batch, batch_idx):
        x, y = batch
        t_eval, y_hat = self.model(x, self.t_span)
        y_hat = y_hat[-1]  # select last point of solution trajectory
        loss = nn.CrossEntropyLoss()(y_hat, y)
        return {'loss': loss}

    def configure_optimizers(self):
        return torch.optim.Adam(self.model.parameters(), lr=0.01)

    def train_dataloader(self):
        return trainloader

f = nn.Sequential(DataControl(),
                  nn.Linear(8+2, 32),
                  nn.ReLU(),
                  nn.Linear(32, 32),
                  nn.ReLU(),
                  nn.Linear(32, 2))

t_span = td.t

# Neural ODE
model = NeuralODE(f, sensitivity='adjoint', solver='tsit5', atol=1e-3, rtol=1e-3).to(device)
learn = Learner(t_span, model)

trainer = pl.Trainer(min_epochs=1, max_epochs=1)
trainer.fit(learn)
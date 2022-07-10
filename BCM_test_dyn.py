import torch
import hickle
import numpy as np
import pandas as pd
from torch.utils.data import Dataset

device = torch.device('cpu')
mode = 1

if mode == 0:
    model = hickle.load('Current_network.hkl')
else:
    model = hickle.load('Voltage_network.hkl')

class TraceDataset(Dataset):
    """ Dataset for loading traces"""

    def __init__(self, csv_file):
        self.tracedf = pd.read_csv(csv_file)
        # self.tracedf = self.tracedf.apply(lambda x: x * 500000)
        if mode == 0:
            self.x = torch.tensor(self.tracedf[["I_mg_d", "I_mg_q"]].values).float().to(device)
            self.y = torch.tensor(self.tracedf[["Id2", "Iq2", "VBat2ds", "VBat2qs", "V_mg_d", "V_mg_q", "Vd2", "Vq2"]].
                                  values).float().to(device)
        else:
            self.x = torch.tensor(self.tracedf[["V_mg_d", "V_mg_q"]].values).float().to(device)
            self.y = torch.tensor(self.tracedf[["I_mg_d", "I_mg_q", "Id2", "Iq2", "VBat2ds", "VBat2qs", "Vd2", "Vq2"]].
                                  values).float().to(device)
        self.t = torch.tensor(np.linspace(0, 3, len(self.tracedf))).float().squeeze().to(device)

    def __len__(self):
        return len(self.tracedf)

    def __getitem__(self, idx):
        sample = {'x': self.x[idx, :], 'y': self.y[idx, :], 't': self.t[idx]}
        return sample

td = TraceDataset('Test_trace_2.csv')
t_span = td.t
X = td.x
Y = td.y

action = model.forward(t_span,X,Y)
print(action)
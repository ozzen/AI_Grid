import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import keras
from keras.layers import Dense
from keras.models import Sequential
from sklearn.model_selection import train_test_split

# BCM constraints
I_mg_d_ref = 0.1689
I_mg_q_ref = 0.0909
Id2_ref = -0.6183
Iq2_ref = 0
VBat2ds_ref = 0.2466
VBat2qs_ref = 1.1902
V_mg_d_ref = 12.4462
V_mg_q_ref = 0.6677
Vd2_ref = 0.4852
Vq2_ref = -0.0182
dev = 0.05
safe_dev = 0.045

# generates initial configuration
def D1(flag):
    I_mg_d = np.random.uniform(low=I_mg_d_ref - dev * I_mg_d_ref, high=I_mg_d_ref + dev * I_mg_d_ref)
    I_mg_q = np.random.uniform(low=I_mg_q_ref - dev * I_mg_q_ref, high=I_mg_q_ref + dev * I_mg_q_ref)
    Id2 = np.random.uniform(low=Id2_ref + dev * Id2_ref, high=Id2_ref - dev * Id2_ref)
    Iq2 = np.random.uniform(low=Iq2_ref, high=Iq2_ref)
    VBat2ds = np.random.uniform(low=VBat2ds_ref - dev * VBat2ds_ref, high=VBat2ds_ref + dev * VBat2ds_ref)
    VBat2qs = np.random.uniform(low=VBat2qs_ref - dev * VBat2qs_ref, high=VBat2qs_ref + dev * VBat2qs_ref)
    V_mg_d = np.random.uniform(low=V_mg_d_ref - dev * V_mg_d_ref, high=V_mg_d_ref + dev * V_mg_d_ref)
    V_mg_q = np.random.uniform(low=V_mg_q_ref - dev * V_mg_q_ref, high=V_mg_q_ref + dev * V_mg_q_ref)
    if flag % 2 == 0:
        Vd2 = np.random.uniform(low=Vd2_ref - 2 * dev * Vd2_ref, high=Vd2_ref - dev * Vd2_ref)
    else:
        Vd2 = np.random.uniform(low=Vd2_ref + dev * Vd2_ref, high=Vd2_ref + 2 * dev * Vd2_ref)
    Vq2 = np.random.uniform(low=Vq2_ref + dev * Vq2_ref, high=Vq2_ref - dev * Vq2_ref)

    state = np.array([I_mg_d, I_mg_q, Id2, Iq2, VBat2ds, VBat2qs, V_mg_d, V_mg_q, Vd2, Vq2])
    dataset = 1
    return state, dataset

def D2(flag):
    I_mg_d = np.random.uniform(low=I_mg_d_ref - dev * I_mg_d_ref, high=I_mg_d_ref + dev * I_mg_d_ref)
    I_mg_q = np.random.uniform(low=I_mg_q_ref - dev * I_mg_q_ref, high=I_mg_q_ref + dev * I_mg_q_ref)
    Id2 = np.random.uniform(low=Id2_ref + dev * Id2_ref, high=Id2_ref - dev * Id2_ref)
    Iq2 = np.random.uniform(low = Iq2_ref, high = Iq2_ref)
    VBat2ds = np.random.uniform(low=VBat2ds_ref - dev * VBat2ds_ref, high=VBat2ds_ref + dev * VBat2ds_ref)
    VBat2qs = np.random.uniform(low=VBat2qs_ref - dev * VBat2qs_ref, high=VBat2qs_ref + dev * VBat2qs_ref)
    V_mg_d = np.random.uniform(low=V_mg_d_ref - dev * V_mg_d_ref, high=V_mg_d_ref + dev * V_mg_d_ref)
    V_mg_q = np.random.uniform(low=V_mg_q_ref - dev * V_mg_q_ref, high=V_mg_q_ref + dev * V_mg_q_ref)
    if flag % 2 == 0:
        Vd2 = np.random.uniform(low=Vd2_ref - safe_dev * Vd2_ref, high=Vd2_ref)
    else:
        Vd2 = np.random.uniform(low=Vd2_ref, high=Vd2_ref + safe_dev * Vd2_ref)
    Vq2 = np.random.uniform(low=Vq2_ref + dev * Vq2_ref, high=Vq2_ref - dev * Vq2_ref)

    state = np.array([I_mg_d, I_mg_q, Id2, Iq2, VBat2ds, VBat2qs, V_mg_d, V_mg_q, Vd2, Vq2])
    dataset = 2
    return state, dataset

def D3(flag):
    I_mg_d = np.random.uniform(low=I_mg_d_ref - dev * I_mg_d_ref, high=I_mg_d_ref + dev * I_mg_d_ref)
    I_mg_q = np.random.uniform(low=I_mg_q_ref - dev * I_mg_q_ref, high=I_mg_q_ref + dev * I_mg_q_ref)
    Id2 = np.random.uniform(low=Id2_ref + dev * Id2_ref, high=Id2_ref - dev * Id2_ref)
    Iq2 = np.random.uniform(low = Iq2_ref, high = Iq2_ref)
    VBat2ds = np.random.uniform(low=VBat2ds_ref - dev * VBat2ds_ref, high=VBat2ds_ref + dev * VBat2ds_ref)
    VBat2qs = np.random.uniform(low=VBat2qs_ref - dev * VBat2qs_ref, high=VBat2qs_ref + dev * VBat2qs_ref)
    V_mg_d = np.random.uniform(low=V_mg_d_ref - dev * V_mg_d_ref, high=V_mg_d_ref + dev * V_mg_d_ref)
    V_mg_q = np.random.uniform(low=V_mg_q_ref - dev * V_mg_q_ref, high=V_mg_q_ref + dev * V_mg_q_ref)
    if flag % 2 == 0:
        Vd2 = np.random.uniform(low=Vd2_ref - dev * Vd2_ref, high=Vd2_ref - safe_dev * Vd2_ref)
    else:
        Vd2 = np.random.uniform(low=Vd2_ref + safe_dev * Vd2_ref, high=Vd2_ref + dev * Vd2_ref)
    Vq2 = np.random.uniform(low=Vq2_ref + dev * Vq2_ref, high=Vq2_ref - dev * Vq2_ref)

    state = np.array([I_mg_d, I_mg_q, Id2, Iq2, VBat2ds, VBat2qs, V_mg_d, V_mg_q, Vd2, Vq2])
    dataset = 3
    return state, dataset

unsafe1 = []
unsafe2 = []
safe1 = []
safe2 = []
safe3 = []
safe4 = []

for i in range(500000):
    state, dataset = D1(0)
    unsafe1.append(state)
    state, dataset = D1(1)
    unsafe2.append(state)

for i in range(500000):
    state, dataset = D2(0)
    safe1.append(state)
    state, dataset = D2(1)
    safe2.append(state)

for i in range(500000):
    state, dataset = D3(0)
    safe3.append(state)
    state, dataset = D3(1)
    safe4.append(state)

df1 = pd.DataFrame(safe1,columns=['I_mg_d', 'I_mg_q', 'Id2', 'Iq2', 'VBat2ds', 'VBat2qs', 'V_mg_d', 'V_mg_q', 'Vd2', 'Vq2'])
df1['u'] = pd.Series([np.random.uniform(-0.01,-0.001) for x in range(len(df1.index))])
df2 = pd.DataFrame(safe2,columns=['I_mg_d', 'I_mg_q', 'Id2', 'Iq2', 'VBat2ds', 'VBat2qs', 'V_mg_d', 'V_mg_q', 'Vd2', 'Vq2'])
df2['u'] = pd.Series([np.random.uniform(-0.01,-0.001) for x in range(len(df2.index))])

df3 = pd.DataFrame(safe3,columns=['I_mg_d', 'I_mg_q', 'Id2', 'Iq2', 'VBat2ds', 'VBat2qs', 'V_mg_d', 'V_mg_q', 'Vd2', 'Vq2'])
df3['u'] = pd.Series([np.random.uniform(-0.001,0) for x in range(len(df3.index))])
df4 = pd.DataFrame(safe4,columns=['I_mg_d', 'I_mg_q', 'Id2', 'Iq2', 'VBat2ds', 'VBat2qs', 'V_mg_d', 'V_mg_q', 'Vd2', 'Vq2'])
df4['u'] = pd.Series([np.random.uniform(-0.001,0) for x in range(len(df4.index))])

df5 = pd.DataFrame(unsafe1,columns=['I_mg_d', 'I_mg_q', 'Id2', 'Iq2', 'VBat2ds', 'VBat2qs', 'V_mg_d', 'V_mg_q', 'Vd2', 'Vq2'])
df5['u'] = pd.Series([np.random.uniform(0.0001,0.01) for x in range(len(df5.index))])
df6 = pd.DataFrame(unsafe1,columns=['I_mg_d', 'I_mg_q', 'Id2', 'Iq2', 'VBat2ds', 'VBat2qs', 'V_mg_d', 'V_mg_q', 'Vd2', 'Vq2'])
df6['u'] = pd.Series([np.random.uniform(0.0001,0.01) for x in range(len(df6.index))])

frames = [df1, df2, df3, df4, df5, df6]
df = pd.concat(frames, ignore_index=True)
print(len(df))
# df.to_csv('data.csv')

#adjust for NN usage
input = ['I_mg_d', 'I_mg_q', 'Id2', 'Iq2', 'VBat2ds', 'VBat2qs', 'V_mg_d', 'V_mg_q', 'Vd2', 'Vq2']
output = ['u']
x = df[input]
y = df[output]
X_train = x.values
Y_train = y.values
# X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size=0.01)

#DNN training
model = Sequential()
n_cols = X_train.shape[1]

#hidden layers
model.add(Dense(10, activation='relu', input_shape=(n_cols,)))
model.add(Dense(10, activation='relu'))

#output layers
model.add(Dense(1))

#optimization
adam = keras.optimizers.Adam(learning_rate=0.0001, beta_1=0.9, beta_2=0.999, epsilon=1e-08, decay=0.0, amsgrad=False)

model.compile(optimizer='adam', loss='mean_squared_error', metrics =['accuracy'])
model.summary()

#training
history = model.fit(X_train, Y_train, batch_size=2000, epochs=2000, verbose=1)

#training error visualization
# plt.plot(history.history['val_loss'])
plt.plot(history.history['loss'])
plt.title('Model Loss')
plt.ylabel('Error')
plt.xlabel('Epoch')
# plt.legend(['val_loss','train_loss'])
plt.show()

#saving NN model
model.save("candidateBC.h5")
# model.save_weights("Results/candidateBC_weights.h5")
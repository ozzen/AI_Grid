import numpy as np
import pandas as pd
from keras.models import load_model

model = load_model('candidateBC.h5')
mode = 0

if mode == 0:
    state = [[0.169780367, 0.092925863, -0.618292217, -3.94e-06, 0.2463826, 1.190239114, 12.44602956, 0.668271255, 0.510, -0.018176499]]
    action = model.predict(state)
    print(action)
    exit()

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

# U = -1
for i in range(100):
    data = []
    state, dataset = D3(2)
    data.append(state)
    df4 = pd.DataFrame(data, columns=['I_mg_d', 'I_mg_q', 'Id2', 'Iq2', 'VBat2ds', 'VBat2qs', 'V_mg_d', 'V_mg_q', 'Vd2', 'Vq2'])
    input = ['I_mg_d', 'I_mg_q', 'Id2', 'Iq2', 'VBat2ds', 'VBat2qs', 'V_mg_d', 'V_mg_q', 'Vd2', 'Vq2']
    z_test = df4[input]
    Z_test = z_test.values
    action = model.predict(Z_test)
    u = float(action[0])
    print(u)
    # if u > U and u < 0:
    #     print(state)
    #     U = u
    if dataset == 1:
        if u > 0:
            R = True
        else:
            R = False
    if dataset == 2:
        if u <= 0:
            R = True
        else:
            R = False
    if dataset == 3:
        if u <= 0 and u >= -0.002:
            R = True
        else:
            R = False
    print(R)
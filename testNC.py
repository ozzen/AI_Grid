import pandas as pd
from tensorflow.keras.models import load_model

model = load_model('NC.h5')
df = pd.read_csv(r"C:\Users\jb891\Desktop\BCM MG Model\Code\Data\Test_Trace.csv")

actions = []
count = 0

for i in range(1,len(df.index)):
    input = df.iloc[i].to_numpy()
    state = [input[0],input[1],input[2],input[3],input[4],input[5]]
    action = model.predict([state])
    action = action[0]
    actions.append(action)
    count = count + 1
    print(count)

DF = pd.DataFrame(actions, columns = ['Vbat2ds','Vbat2qs'])
DF.to_csv("Learned.csv", header=False, index=False)

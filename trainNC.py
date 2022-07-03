import pandas as pd
import matplotlib.pyplot as plt
from tensorflow.keras.layers import Dense
from tensorflow.keras.models import Sequential
from tensorflow.keras.optimizers import Adam
from sklearn.model_selection import train_test_split

# data processing
df = pd.read_csv(r"C:\Users\jb891\Desktop\BCM MG Model\Data_1\Trace_1.csv")
input = ['Id2', 'Iq2', 'Iref_d2', 'Iref_q2', 'Vd2', 'Vq2']
output = ['VBat2ds', 'VBat2qs']

# adjust for NN usage
x = df[input]
y = df[output]
X_train = x.values
Y_train = y.values
X_train, X_test, Y_train, Y_test = train_test_split(X_train, Y_train, test_size=0.10)

# dnn training
model = Sequential()
n_cols = X_train.shape[1]

# hidden layers
model.add(Dense(10, activation='relu', input_shape=(n_cols,)))
model.add(Dense(10, activation='relu'))

# output layers
model.add(Dense(2))

#optimization
adam = Adam(learning_rate=0.0001, beta_1=0.9, beta_2=0.999, epsilon=1e-08, decay=0.0, amsgrad=False)
model.compile(optimizer='adam', loss='mean_squared_error', metrics =['accuracy'])
model.summary()

#training
history = model.fit(X_train, Y_train, validation_data=(X_test,Y_test), batch_size=1000, epochs=1000, verbose=1)

#training error visualization
plt.plot(history.history['val_loss'])
plt.plot(history.history['loss'])
plt.title('Model Loss')
plt.ylabel('Error')
plt.xlabel('Epoch')
plt.legend(['val_loss','train_loss'])
plt.show()

#saving NN model
model.save("NC.h5")
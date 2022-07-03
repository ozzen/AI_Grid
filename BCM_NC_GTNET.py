import socket
import time
import struct
import tensorflow as tf
from tensorflow.keras.models import load_model

actor = load_model('NC.h5')

TCP_IP = '172.20.28.72'
TCP_PORT = 4575
BUFFER_SIZE = 1024
dur = 0.0
i = 1

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((TCP_IP, TCP_PORT))

while i > 0:
    try:
        if i == 1:
            u1 = 0.0
            u2 = 0.0
            i = i+1
        else:
            state_tf = tf.expand_dims(tf.convert_to_tensor(state), 0)
            action = actor.predict(state_tf)
            action = action[0]
            u1 = float(action[0])
            u2 = float(action[1])
        send_data_str = struct.pack('>ffi', u1, u2, i)
        start = time.perf_counter()
        s.send(send_data_str)
        recv_data_str = s.recv(BUFFER_SIZE)
        end = time.perf_counter()
        dur = dur + (end - start)
        recv_data_str_unpacked = struct.unpack('>ffffff', recv_data_str)
        Id2 = float(recv_data_str_unpacked[0])
        Iq2 = float(recv_data_str_unpacked[1])
        Iref_d2 = float(recv_data_str_unpacked[2])
        Iref_q2 = float(recv_data_str_unpacked[3])
        Vd2 = float(recv_data_str_unpacked[4])
        Vq2 = float(recv_data_str_unpacked[5])
        state = [Id2, Iq2, Iref_d2, Iref_q2, Vd2, Vq2]
    except struct.error:
        time.sleep(1)  # This sleep is needed for the ClosePort() below
        s.close()
        print('All iterations complete.')
        print('The total execution time is %fs.' % dur)
    except OSError:
        exit()

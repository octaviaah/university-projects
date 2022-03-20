import time
from socket import *
from threading import Thread

def f(connectionSocket, i):
    print("Processing client " + str(i))
    message = connectionSocket.recv(100).decode()
    print(message)
    time.sleep(10)
    connectionSocket.send(str(i).encode())
    connectionSocket.close()

serverPort = 7777
serverSocket = socket(AF_INET, SOCK_STREAM)
serverSocket.bind(('', serverPort))
serverSocket.listen(5)
print('The server is ready to receive')
i=0
while True:
    i = i+1
    connectionSocket, addr = serverSocket.accept()
    t = Thread(target=f, args=(connectionSocket,i,))
    t.start()
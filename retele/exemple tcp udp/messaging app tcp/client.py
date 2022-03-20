import threading
from socket import *

serverName = 'localhost'
serverPort = 12000
clientSocket = socket(AF_INET, SOCK_STREAM)
clientSocket.connect((serverName, serverPort))

startingMessage = "START"
clientSocket.send(startingMessage.encode())

def run_thread():
    while True:
        data  = clientSocket.recv(1024)
        print("\nServer: {}".format(data.decode()))
        print(">>> [CLIENT] Send message: ",)


threading.Thread(target = run_thread).start()

while True:
    print(">>> [CLIENT] Send message: ",)
    txt = input()
    clientSocket.send(txt.encode())
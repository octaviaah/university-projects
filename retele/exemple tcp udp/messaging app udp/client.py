import socket
import threading
from socket import *

serverName = 'localhost'
serverPort = 1234

# client socket
clientSocket = socket(AF_INET, SOCK_DGRAM)

startingMessage = "START"
clientSocket.sendto(startingMessage.encode(), (serverName, serverPort))

def run_thread():
    while True:
        data, addr = clientSocket.recvfrom(1024)
        print("\nServer: {}".format(data.decode()))
        print(">>> [CLIENT] Send message: ",)


threading.Thread(target = run_thread).start()

while True:
    print(">>> [CLIENT] Send message: ",)
    txt = input()
    clientSocket.sendto(txt.encode(), (serverName, serverPort))
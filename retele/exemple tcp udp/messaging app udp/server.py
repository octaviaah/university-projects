from socket import *
import threading

serverPort = 1234
serverName = 'localhost'

# server socket
serverSocket = socket(AF_INET, SOCK_DGRAM)
serverSocket.bind((serverName, serverPort))

data, client_address = serverSocket.recvfrom(5)
print(data.decode())

def run_thread():
    while True:
        data, addr = serverSocket.recvfrom(1024)
        print("\nClient: {}".format(data.decode()))
        print(">>> [SERVER] Send message: ",)

threading.Thread(target=run_thread).start()

while True:
    print(">>> [SERVER] Send message:",)
    txt = input()
    serverSocket.sendto(txt.encode(), client_address)
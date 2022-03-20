from socket import *
import threading

serverPort = 12000
serverSocket = socket(AF_INET, SOCK_STREAM)
serverSocket.bind(('', serverPort))
serverSocket.listen(1)

connectionSocket, addr = serverSocket.accept()
data= connectionSocket.recv(1024).decode()
print(data)

def run_thread():
    while True:
        data= connectionSocket.recv(1024).decode()
        print("\nClient: {}".format(data))
        print(">>> [SERVER] Send message: ",)

threading.Thread(target=run_thread).start()

while True:
    print(">>> [SERVER] Send message:",)
    txt = input()
    connectionSocket.sendall(txt.encode())
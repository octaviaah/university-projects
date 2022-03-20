import time
from socket import *
from threading import Thread
from numpy import *
from numpy import array


def f(connectionSocket, i):
    print("Processing client " + str(i))
    message = connectionSocket.recv(100).decode()
    print(message)
    table = array([
                    ['-', '-', '*', '-', '*', '-', '-', '-'],
                    ['*', '-', '*', '-', '-', '-', '*', '-'],
                    ['-', '-', '-', '-', '*', '-', '-', '-'],
                    ['-', '*', '-', '-', '-', '-', '-', '*'],
                    ['-', '-', '-', '-', '-', '*', '*', '-'],
                    ['-', '*', '*', '-', '-', '-', '-', '-'],
                    ['-', '-', '-', '-', '*', '-', '-', '-'],
                    ['-', '-', '*', '-', '*', '-', '-', '-'],
    ])
    startMessage = "The table is 8*8"
    connectionSocket.send(startMessage.encode())
    time.sleep(3)
    line = int(connectionSocket.recv(4).decode())
    column = int(connectionSocket.recv(4).decode())
    print("I received from  client " + str(i) + " the line " + str(line) + " and column " + str(column))
    if table[line-1][column-1] == '*':
        print("Client " + str(i) + " found a part of the plane")
        goodMessage = "You found a part of the plane!"
        connectionSocket.send(goodMessage.encode())
    else:
        print("Client " + str(i) + " found the water")
        badMessage = "Sorry, you found the water!"
        connectionSocket.send(badMessage.encode())
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
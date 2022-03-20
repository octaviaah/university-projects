from socket import *

serverName = 'localhost'
serverPort = 7777
clientSocket = socket(AF_INET, SOCK_STREAM)
clientSocket.connect((serverName, serverPort))
print("I connected to server " + serverName)
sentence = "Hello server, I am " + str(clientSocket.getpeername())
clientSocket.send(sentence.encode())
startMessage = clientSocket.recv(1024).decode()
print(startMessage)
line = input("Enter line: ")
column = input("Enter column: ")
clientSocket.send(str(line).encode())
clientSocket.send(str(column).encode())
message = clientSocket.recv(100).decode()
print(message)
clientSocket.close()
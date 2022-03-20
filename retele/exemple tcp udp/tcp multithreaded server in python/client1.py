from socket import *

serverName = 'localhost'
serverPort = 7777
clientSocket = socket(AF_INET, SOCK_STREAM)
clientSocket.connect((serverName, serverPort))
print("I connected to server " + serverName)
sentence = "Hello server, I am " + str(clientSocket.getpeername())
clientSocket.send(sentence.encode())
message = clientSocket.recv(10).decode()
print("I received: " + message)
clientSocket.close()
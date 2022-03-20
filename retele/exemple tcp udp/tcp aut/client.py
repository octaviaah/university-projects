from socket import *

serverName = 'localhost'
serverPort = 12000
clientSocket = socket(AF_INET, SOCK_STREAM)
clientSocket.connect((serverName, serverPort))
sentence = input('Write a sentence: ')
clientSocket.sendall(sentence.encode())
modifiedSentence = clientSocket.recv(1024).decode()
print("I received from server: ", modifiedSentence)
clientSocket.close()
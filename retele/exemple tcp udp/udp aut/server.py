from socket import *
serverPort = 12000
serverSocket = socket(AF_INET, SOCK_DGRAM)
serverSocket.bind(("", serverPort))
print("The server is ready to receive")
while True:
    message, clientAddress = serverSocket.recvfrom(2048)
    print("I received the message: " + message.decode())
    modifiedMessage = message.decode().upper()
    print("I send the message: " + modifiedMessage)
    serverSocket.sendto(modifiedMessage.encode(), clientAddress)
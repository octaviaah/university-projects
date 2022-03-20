import socket

cs = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
message = "hey"
cs.sendto(str.encode(message),("127.0.0.1",5555))
message, addr = cs.recvfrom(10)
print(message.decode())
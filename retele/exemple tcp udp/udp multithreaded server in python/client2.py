import socket
import time

cs = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
message = "client 2 says hey"
cs.sendto(str.encode(message),("127.0.0.1",5555))
message, addr = cs.recvfrom(100)
print(message.decode())
time.sleep(3)
import socket

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.bind(("0.0.0.0",5555))
buffer, addr = s.recvfrom(10)
print(buffer.decode())
s.sendto(bytes("hello",'ascii'), addr)
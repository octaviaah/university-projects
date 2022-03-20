import socket

cs = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
cs.connect(('127.0.0.1',7777))
cs.send(bytes("Salut",'ascii'))
message = cs.recv(10).decode()
print(message)
cs.close()
import socket, os

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect(("127.0.0.1", 5555))
s.send(bytes("Hello", 'ascii'))
if os.fork() == 0:
        while 1:
            print(s.recv(100).decode())
            exit(0)
while 1:
    data = input()
    s.send(bytes(data,'ascii'))
s.close()
import time
import socket
from threading import Thread

def f(buffer, addr, i):
    print("Procesez client " + str(i))
    message = buffer.decode()
    print(message)
    time.sleep(10)
    s.sendto(bytes(str(i), 'ascii'), addr)

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.bind(("0.0.0.0",5555))
i=0
while True:
    i = i+1
    buffer, addr = s.recvfrom(100)
    t = Thread(target=f, args=(buffer, addr ,i,))
    t.start()
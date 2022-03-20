import pickle
import select
import socket
import sys

if __name__ == "__main__":
    tcp_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)#set up tcp socket
    tcp_sock.connect(('127.0.0.1', 7000))#connect socket to the server
    udp_sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)#set up udp socket
    udp_sock.bind(tcp_sock.getsockname())#bind socket to tcp sock address
    connections = []
    connections_count = int.from_bytes(tcp_sock.recv(4), "big")#count all the connections

    for _ in range(connections_count): #for all connections
        size = int.from_bytes(tcp_sock.recv(4), "big") #get size of the address from the server
        addr = pickle.loads(tcp_sock.recv(size)) #get the address from the server
        connections.append(addr) #append the address to the connections

    inputs = [tcp_sock, udp_sock, sys.stdin]
    done = False
    while not done:
        r, w, e = select.select(inputs, [], [])
        for input_place in r:
            if input_place == sys.stdin:
                msg = input()
                if msg == "QUIT":
                    tcp_sock.close()
                    udp_sock.close()
                    done = True
                else:
                    for connection in connections:
                        udp_sock.sendto(msg.encode("ascii"), connection)
            elif input_place == tcp_sock:
                size = int.from_bytes(tcp_sock.recv(4), "big")
                addr = pickle.loads(tcp_sock.recv(size))
                if addr in connections:
                    print(addr, "disconnected")
                    connections.remove(addr)
                else:
                    print(addr, "connected")
                    connections.append(addr)
            elif input_place == udp_sock:
                msg, addr = udp_sock.recvfrom(1024)
                msg = msg.decode("ascii")
                print(addr, ":", msg)
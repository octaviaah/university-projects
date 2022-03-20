import pickle
import select
import socket
import threading

done = False
connections = [] #list of connections
check_lock = threading.Lock() #check if client is done sending messages
connections_lock = threading.Lock() #update connections


def reader(udp_sock):
    global done
    while not done: #while socket still functions
        message = input() #input messages
        if message == "QUIT": #if client wants to quit
            check_lock.acquire()
            done = True #client is done sending messages
            check_lock.release()
        else:
            connections_lock.acquire()
            for connection in connections: #for every connection
                udp_sock.sendto(message.encode("ascii"), connection) #send the client's message to everyone using udp
            connections_lock.release()


if __name__ == "__main__":
    tcp_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)#set up tcp socket
    tcp_sock.connect(('127.0.0.1', 7000))#connect socket to the server
    udp_sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)#set up udp socket
    udp_sock.bind(tcp_sock.getsockname())#bind socket to tcp sock address
    connections_count = int.from_bytes(tcp_sock.recv(4), "big")#count all the connections

    for _ in range(connections_count): #for all connections
        size = int.from_bytes(tcp_sock.recv(4), "big") #get size of the address from the server
        addr = pickle.loads(tcp_sock.recv(size)) #get the address from the server
        connections.append(addr) #append the address to the connections

    udp_sock.setblocking(False)
    tcp_sock.setblocking(False)

    reader_thread = threading.Thread(target=reader, args=(udp_sock,)) #set up threads to allow multiple clients to
    # connect simultaneously
    reader_thread.start() #start threads
    inputs = [tcp_sock, udp_sock] #starting sockets are tcp and udp
    check_lock.acquire()

    while not done:
        check_lock.release()
        r, w, e = select.select(inputs, [], [], 1) #select socket
        for sock in r: #for every sock in the list of sockets
            if sock == tcp_sock: #if the socket is the tcp one
                size = int.from_bytes(tcp_sock.recv(4), "big") #get the size of an address from the server
                addr = pickle.loads(tcp_sock.recv(size)) #gets the address of a client from the server
                if addr in connections: #if address in the connections list
                    print(addr, "disconnected") #say that the client has disconnected
                    connections_lock.acquire()
                    connections.remove(addr) #remove client from connections
                    connections_lock.release()
                else: #if address is not yet connected
                    print(addr, 'connected') #say that client has connected
                    connections_lock.acquire()
                    connections.append(addr) #add client to connections
                    connections_lock.release()
            elif sock == udp_sock: #if sock is udp
                message, addr = udp_sock.recvfrom(1024) #get messages from other clients
                message = message.decode("ascii") #decode the messages
                print(addr, ":", message) #and print them
        check_lock.acquire()
    check_lock.release()
    tcp_sock.close() #close the sockets
    udp_sock.close()

#send - folosit in server - sends data to clients
#     - folosit in client - sends data to server
#recv - folosit in server - receives data from clients
#     - folosit in client - receives data from server
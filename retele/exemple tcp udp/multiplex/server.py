import pickle
import select
import socket
import sys


def send_all_clients(server, sockets, address):
    for client in sockets: #for all existing clients and servers
        if client != server: #if client is not a server
            sending = pickle.dumps(address) #the new client address is sent through pickle
            client.send(sys.getsizeof(sending).to_bytes(4, "big")) #the client gets the size of the new client address
            client.send(sending) #and the new client address

def send_client_all_addresses(client, addresses):
    client.send(len(addresses).to_bytes(4, byteorder="big")) #the client gets the length of the list of addresses
    for address in addresses: #for every address
        sending = pickle.dumps(address) #the adress is sent through pickle
        client.send(sys.getsizeof(sending).to_bytes(4, "big")) #gets the size of the address
        client.send(sending) #gets the addressses

if __name__ == "__main__":
    ss = socket.socket(socket.AF_INET, socket.SOCK_STREAM) #we create a tcp socket
    ss.bind(('0.0.0.0', 7000)) #assign an universal address to the socket
    ss.setblocking(False)
    ss.listen(5)
    clients = [] #list of clients
    inputs = [ss] #right now, we only have the server socket

    while True:
        r, w, e = select.select(inputs, [], []) #we select a socket from inputs
        for sock in r: #for every sock in r
            if sock == ss: #if the sock is the server sock
                new_cs, addr = ss.accept() #it accepts connections from clients
                print("New client: ", addr) #shows a message that a new client has connected
                send_all_clients(ss, inputs, addr) #sends the address of the new client to the other clients
                send_client_all_addresses(new_cs, clients) #sends their addresses to the new client
                inputs.append(new_cs) #the new client socket is added to the inputs(list of current sockets)
                clients.append(addr) #the new client is appended to the list of clients
            else: #if the sock is a client sock
                read = sock.recv(4) #receives information from client
                addr = sock.getpeername() #gets its address
                print("Client left: ", addr) #prints a message that the client has left
                inputs.remove(sock) #removes the client socket from the list of sockets
                clients.remove(addr) #removes the client from the list of clients
                send_all_clients(ss, inputs, addr) #sends the list of client sockets to all remaining clients
                sock.close() #closes the client socket

#atunci cand sock este client, este trimisa adresa clientului care a iesit la ceilalti clienti pt ca ei sa l scoata
# din lista. pt ca ei primesc adresa clientului x si il gasesc in lista lor de conexiuni, isi dau seama ca a iesit si
# il scot din lista lor de conexiuni. daca adresa clientului x nu se gaseste in lista lor de conexiuni,
# ins ca el abia acum s a conectat si trb adaugat
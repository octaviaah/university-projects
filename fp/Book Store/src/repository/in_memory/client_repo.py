from random import choice

from src.data_structure.data_structure import DataStructure, filter, gnome_sort
from src.domain.client import Client

class clientRepoError(Exception):
    '''
    prints an exception related to the book class
    '''
    def __init__(self, msg):
        self._msg = msg


class ClientRepository:

    def __init__(self, clients=None):
        '''
        creates the client repository
        :param clients: if we already have a client list, otherwise none
        '''
        self._clients = DataStructure()
        if clients is not None:
            self.add_all(clients)

    @property
    def clients(self):
        '''
        returns the list of clients
        :return: list of client - list type
        '''
        return self._clients

    def add_all(self, clients):
        '''
        adds a preexistent client list
        :param clients: the preexistent list
        :return:
        '''
        self._clients = clients

    def __len__(self):
        '''
        returns the length of the client list
        :return: the length - int
        '''
        return len(self._clients)

    def find(self, other_id):
        for index in self._clients:
            if self._clients[index].client_id == other_id:
                return self._clients[index]

    def find_by_id(self, other_id):
        '''
        finds client by id
        :param other_id: the id we search, to see if it exists or not
        :return: 1 if the client was found, 0 if not
        '''
        for index in self._clients:
            if self._clients[index].client_id == other_id:
                return 1
        return 0

    def is_integer(self, x):
        '''
        verifies if the numeric string is integer
        :param x: the numeric string
        :return: true, if it is an integer, false otherwise
        '''
        try:
            int(x)
        except ValueError:
            return False
        return True

    def add(self, client):
        '''
        adds client to list
        :param client: client id, name
        :return:
        '''
        self._clients[client.client_id] = client

    def remove(self, client_id):
        '''
        removes client from list
        :param client_id: id of client - int
        :return: client that was removed(for undo/redo)
        '''
        client = self.find(client_id)
        del self._clients[client_id]
        return client

    def update(self, name, new_name):
        '''
        updates client name
        :param name: old name - str
        :param new_name: new name - str
        :return:
        '''
        name_exists = 0
        for index in self._clients:
            if self._clients[index].name == name:
                name_exists = 1
                self._clients[index].name = new_name
        if name_exists == 0:
            raise clientRepoError("No client with this name!")

    def search_id(self, client_id):
        client_id = client_id.strip()
        if self.is_integer(client_id) is False:
            raise clientRepoError("ID must be an integer!")
        if int(client_id) <= 0:
            raise clientRepoError("ID cannot be a negative number!")
        return list(filter(lambda client: str(client_id) in str(client.client_id), self.clients.values()))

    def search_name(self, name):
        if name == '':
            raise clientRepoError("Name cannot be empty string!")
        return list(filter(lambda client: name.strip().lower() in client.name.lower(), self.clients.values()))

    def test_init(self):
        '''
        initial client list procedurally programmated
        every name appears only once
        :return:
        '''
        client_names = ['John Smith', 'Joe Williams', 'Patricia Johnson', 'Kathy Hudson',
                        'William Bennet', 'Henry Ford', 'Claire Edinson', 'George Washington', 'Ryan Johnson',
                        'Carol Bennet']
        for index in range(10):
            client = choice(client_names)
            client_names.remove(client)
            self._clients[index+1] = Client(index+1, client)

        return self._clients

'''
c = ClientRepository()
c.test_init()
c.clients[11] = Client(11, 'popel')
c.add(Client(13, 'popa'))
c.remove(5)
c.update('popel', 'costel')
sorted_list = c.search_id('2')
for client in sorted_list:
    print(str(client))

print(list(c.clients.data.values()))
'''

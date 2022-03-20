
from src.domain.client import Client, ClientValidator


class clientServiceError(Exception):
    '''
    prints an exception related to the client service class
    '''
    def __init__(self, msg):
        self._msg = msg


class ClientService:
    def __init__(self, repo):
        '''
        gets the repo from client repo
        :param repo: the client repo(or other existent client repo) - list of clients + functions related to it
        '''
        self._repo = repo

    @property
    def repo(self):
        '''
        returns the repo
        :return: the repo - list of clients + functions related to it
        '''
        return self._repo


    def create_client(self, client_id, name):
        '''
        adds client to the list
        :param client_id: the id of the client - unique + int
        :param name: name of the client - str
        :return:
        '''
        if self._repo.find_by_id(client_id) == 1:
            raise clientServiceError("Duplicate ID!")
        new_client = Client(client_id, name)
        cv = ClientValidator()
        cv.validate(new_client)
        self._repo.add(new_client)

    def remove_client(self, client_id):
        '''
        removes client by id
        :param client_id: the id of the client to be removed - int
        :return:
        '''
        if self._repo.find_by_id(client_id) == 0:
            raise clientServiceError('This client does not exist!')
        else:
            client = self._repo.remove(client_id)
            return client

    def update_client(self, name, new_name):
        '''
        updates client name
        :param name: the old name of the client - str
        :param new_name: the new name of the client - str
        :return:
        '''
        if name == '':
            raise clientServiceError("Name entered must not be empty!")
        if isinstance(new_name, str) is False:
            raise clientServiceError("New name must be of str type!")
        if new_name == '':
            raise clientServiceError("New name must not be empty!")
        self._repo.update(name, new_name)

    def search_client(self, client_id, name):
        if client_id == '':
            return self._repo.search_name(name)
        elif name != '':
            raise clientServiceError("You cannot search by 2 things at the same time!")
        else:
            return self._repo.search_id(client_id)





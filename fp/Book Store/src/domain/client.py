class clientException(Exception):
    '''
    prints an exception related to the client class
    '''
    def __init__(self, msg):
        self._msg = msg

class Client:

    def __init__(self, client_id, name):
        '''
        defines a client
        :param client_id: the id of the client - unique! (int)
        :param name: name of the client - str
        '''

        self._client_id = client_id
        self._name = name

    @property
    def client_id(self):
        '''
        gets the id
        :return: id of the client - int
        '''
        return self._client_id

    @property
    def name(self):
        '''
        gets the name
        :return: name of the client - str
        '''
        return self._name

    @name.setter
    def name(self, new_name):
        '''
        sets new name for the client
        :param new_name: the new name for the client - str
        :return:
        '''
        self._name = new_name


    def __str__(self):
        '''
        transforms client data to str
        :return: client data in str
        '''
        return str(self._client_id).rjust(4) + ' | ' + self._name


class ClientValidator:
    def validate(self, client):
        '''
        validates client data
        :param client: entity from client class
        :return:
        '''
        if isinstance(client.client_id, int) is False:
            raise clientException('ID must be an integer!')

        if client.client_id <= 0:
            raise clientException('ID cannot be a negative number!')

        if len(client.name) == 0:
            raise clientException("Name cannot be empty!")


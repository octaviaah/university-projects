from src.data_structure.data_structure import DataStructure
from src.domain.client import Client
from src.repository.in_memory.client_repo import ClientRepository


class ClientTextRepository():
    def __init__(self, file_name):
        super().__init__()
        self.__file_name = file_name
        self.__repo = ClientRepository()

    @property
    def clients(self):
        return self.__repo.clients

    def read_file(self):
        file_data = DataStructure()
        try:
            f = open(self.__file_name, 'r')
            line = f.readline().strip()
            while len(line) > 0:
                line = line.split(";")
                file_data[int(line[0])] = Client(int(line[0]), line[1])
                line = f.readline().strip()
            f.close()
        except IOError as e:
            print("An error has occurred - " + str(e))
            raise e
        return file_data

    def write_file(self):
        f = open(self.__file_name, "w")
        try:
            for client in self.__repo.clients.values():
                client_str = str(client.client_id) + ";" + client.name + '\n'
                f.write(client_str)
            f.close()
        except Exception as e:
            print("An error has occurred -" + str(e))

    def find(self, other_id):
        self.read_file()
        client = self.__repo.find(other_id)
        return client

    def find_by_id(self, other_id):
        self.read_file()
        result = self.__repo.find_by_id(other_id)
        return result

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
        self.read_file()
        self.__repo.add(client)
        self.write_file()

    def remove(self, client_id):
        self.read_file()
        client = self.__repo.remove(client_id)
        self.write_file()
        return client

    def update(self, name, new_name):
        self.read_file()
        self.__repo.update(name, new_name)
        self.write_file()

    def search_id(self, client_id):
        self.read_file()
        return self.__repo.search_id(client_id)

    def search_name(self, name):
        self.read_file()
        return self.__repo.search_name(name)

    def test_init(self):
        self.__repo.add_all(self.read_file())
        if self.__repo.clients.data == {}:
            self.__repo.test_init()
            self.write_file()



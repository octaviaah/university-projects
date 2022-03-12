import json

from src.data_structure.data_structure import DataStructure
from src.domain.client import Client
from src.repository.in_memory.client_repo import ClientRepository


class ClientJSONRepository():
    def __init__(self, file_name):
        super().__init__()
        self.__file_name = file_name
        self.__repo = ClientRepository()

    @property
    def clients(self):
        return self.__repo.clients

    def write_json_file(self):
        f = open(self.__file_name, "wb")
        f.write(json.dumps([x.__dict__ for x in self.__repo.clients.values()], indent=4,).encode())
        f.close()

    def read_json_file(self):
        file_data = DataStructure()
        try:
            f = open(self.__file_name, "rb")
            try:
                data = json.loads(f.read().decode())
                for line in data:
                    file_data[line['_client_id']] = Client(line['_client_id'], line['_name'])
            except ValueError:
                return {}
            finally:
                f.close()
        except IOError as e:
            print("An error has occurred - " + str(e))
            raise e
        return file_data

    def find(self, other_id):
        self.read_json_file()
        client = self.__repo.find(other_id)
        return client

    def find_by_id(self, other_id):
        self.read_json_file()
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
        self.read_json_file()
        self.__repo.add(client)
        self.write_json_file()

    def remove(self, client_id):
        self.read_json_file()
        client = self.__repo.remove(client_id)
        self.write_json_file()
        return client

    def update(self, name, new_name):
        self.read_json_file()
        self.__repo.update(name, new_name)
        self.write_json_file()

    def search_id(self, client_id):
        self.read_json_file()
        return self.__repo.search_id(client_id)

    def search_name(self, name):
        self.read_json_file()
        return self.__repo.search_name(name)

    def test_init(self):
        if self.read_json_file() == {}:
            self.__repo.test_init()
            self.write_json_file()
        self.__repo.add_all(self.read_json_file())


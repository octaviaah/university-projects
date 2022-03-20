import pickle

from src.repository.in_memory.client_repo import ClientRepository


class ClientPickleRepository():
    def __init__(self, file_name):
        super().__init__()
        self.__file_name = file_name
        self.__repo = ClientRepository()

    @property
    def clients(self):
        return self.__repo.clients

    def write_binary_file(self):
        f = open(self.__file_name, "wb")
        pickle.dump(self.__repo.clients, f)
        f.close()

    def read_binary_file(self):
        try:
            f = open(self.__file_name, "rb")
            try:
                return pickle.load(f)
            except EOFError:
                return []
            finally:
                f.close()
        except IOError as e:
            print("An error has occured - " + str(e))
            raise e

    def find(self, other_id):
        self.read_binary_file()
        client = self.__repo.find(other_id)
        return client

    def find_by_id(self, other_id):
        self.read_binary_file()
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
        self.read_binary_file()
        self.__repo.add(client)
        self.write_binary_file()

    def remove(self, client_id):
        self.read_binary_file()
        client = self.__repo.remove(client_id)
        self.write_binary_file()
        return client

    def update(self, name, new_name):
        self.read_binary_file()
        self.__repo.update(name, new_name)
        self.write_binary_file()

    def search_id(self, client_id):
        self.read_binary_file()
        return self.__repo.search_id(client_id)

    def search_name(self, name):
        self.read_binary_file()
        return self.__repo.search_name(name)

    def test_init(self):
        if self.read_binary_file() == []:
            self.__repo.test_init()
            self.write_binary_file()
        self.__repo.add_all(self.read_binary_file())


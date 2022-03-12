import pickle

from src.repository.in_memory.rental_repo import RentalRepository


class RentalPickleRepository():
    def __init__(self, file_name):
        super().__init__()
        self.__file_name = file_name
        self.__repo = RentalRepository()

    @property
    def rentals(self):
        if self.read_binary_file() == []:
            self.write_binary_file()
        self.__repo.add_all(self.read_binary_file())
        return self.__repo.rentals

    def write_binary_file(self):
        f = open(self.__file_name, "wb")
        pickle.dump(self.__repo.rentals, f)
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

    def __len__(self):
        return len(self.__repo.rentals)

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

    def find(self, other_id):
        self.read_binary_file()
        rental = self.__repo.find(other_id)
        return rental

    def find_by_rental_id(self, other_id):
        self.read_binary_file()
        result = self.__repo.find_by_rental_id(other_id)
        return result

    def find_by_book_id(self, other_id):
        self.read_binary_file()
        result = self.__repo.find_by_book_id(other_id)
        return result

    def find_later_date(self, other_id, rented_date):
        self.read_binary_file()
        result = self.__repo.find_later_date(other_id, rented_date)
        return result

    def add(self, rental):
        self.read_binary_file()
        self.__repo.add(rental)
        self.write_binary_file()

    def remove_rental_client(self, client_id):
        self.read_binary_file()
        found_rentals = self.__repo.remove_rental_client(client_id)
        self.write_binary_file()
        return found_rentals

    def remove_rental_book(self, book_id):
        self.read_binary_file()
        found_rentals = self.__repo.remove_rental_book(book_id)
        self.write_binary_file()
        return found_rentals

    def remove_rental_id(self, rental_id):
        self.read_binary_file()
        rental = self.__repo.remove_rental_id(rental_id)
        self.write_binary_file()
        return rental

    def update(self, book_id, returned_date):
        self.read_binary_file()
        self.__repo.update(book_id, returned_date)
        self.write_binary_file()

    def update_reverse(self, book_id, returned_date):
        self.read_binary_file()
        last_rental = self.__repo.update_reverse(book_id, returned_date)
        self.write_binary_file()
        return last_rental
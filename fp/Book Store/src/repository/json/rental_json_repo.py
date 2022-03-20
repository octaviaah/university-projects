import json
from datetime import date

from src.data_structure.data_structure import DataStructure
from src.domain.rental import Rental
from src.repository.in_memory.rental_repo import RentalRepository


class RentalJSONRepository():
    def __init__(self, file_name):
        super().__init__()
        self.__file_name = file_name
        self.__repo = RentalRepository()

    @property
    def rentals(self):
        if self.read_json_file() == {}:
            self.write_json_file()
        self.__repo.add_all(self.read_json_file())
        return self.__repo.rentals

    def write_json_file(self):
        f = open(self.__file_name, "wb")
        f.write(json.dumps([x.__dict__ for x in self.__repo.rentals.values()], indent=4, default=str).encode())
        f.close()

    def read_json_file(self):
        file_data = DataStructure()
        try:
            f = open(self.__file_name, "rb")
            try:
                data = json.loads(f.read().decode())
                for line in data:
                    file_data[line['_rental_id']] = Rental(line['_rental_id'], line['_client_id'], line['_book_id'],
                                            line['_rented_date'], line['_returned_date'])
            except ValueError:
                return {}
            finally:
                f.close()
        except IOError as e:
            print("An error has occurred - " + str(e))
            raise e
        return file_data

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
        self.read_json_file()
        rental = self.__repo.find(other_id)
        return rental

    def find_by_rental_id(self, other_id):
        self.read_json_file()
        result = self.__repo.find_by_rental_id(other_id)
        return result

    def find_by_book_id(self, other_id):
        self.read_json_file()
        result = self.__repo.find_by_book_id(other_id)
        return result

    def find_later_date(self, other_id, rented_date):
        self.read_json_file()
        result = self.__repo.find_later_date(other_id, rented_date)
        return result

    def add(self, rental):
        self.read_json_file()
        self.__repo.add(rental)
        self.write_json_file()

    def remove_rental_client(self, client_id):
        self.read_json_file()
        found_rentals = self.__repo.remove_rental_client(client_id)
        self.write_json_file()
        return found_rentals

    def remove_rental_book(self, book_id):
        self.read_json_file()
        found_rentals = self.__repo.remove_rental_book(book_id)
        self.write_json_file()
        return found_rentals

    def remove_rental_id(self, rental_id):
        self.read_json_file()
        rental = self.__repo.remove_rental_id(rental_id)
        self.write_json_file()
        return rental

    def update(self, book_id, returned_date):
        self.read_json_file()
        self.__repo.update(book_id, returned_date)
        self.write_json_file()

    def update_reverse(self, book_id, returned_date):
        self.read_json_file()
        last_rental = self.__repo.update_reverse(book_id, returned_date)
        self.write_json_file()
        return last_rental


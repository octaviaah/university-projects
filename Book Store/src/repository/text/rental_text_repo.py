from src.data_structure.data_structure import DataStructure
from src.domain.rental import Rental
from src.repository.in_memory.rental_repo import RentalRepository


class RentalTextRepository():
    def __init__(self, file_name):
        super().__init__()
        self.__file_name = file_name
        self.__repo = RentalRepository()

    @property
    def rentals(self):
        self.__repo.add_all(self.read_file())
        return self.__repo.rentals

    def read_file(self):
        file_data = DataStructure()
        try:
            f = open(self.__file_name, 'r')
            line = f.readline().strip()
            while len(line) > 0:
                line = line.split(";")
                file_data[int(line[0])] = Rental(int(line[0]), int(line[1]), int(line[2]), line[3], line[4])
                line = f.readline().strip()
            f.close()
        except IOError as e:
            print("An error has occurred - " + str(e))
            raise e
        return file_data

    def write_file(self):
        f = open(self.__file_name, "w")
        try:
            for rental in self.__repo.rentals.values():
                rental_str = str(rental.rental_id) + ";" + str(rental.client_id) + ";" + str(rental.book_id) + ";" + \
                             str(rental.rented_date) + ";" + str(rental.returned_date) + '\n'
                f.write(rental_str)
            f.close()
        except Exception as e:
            print("An error has occurred -" + str(e))

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
        self.read_file()
        rental = self.__repo.find(other_id)
        return rental

    def find_by_rental_id(self, other_id):
        self.read_file()
        result = self.__repo.find_by_rental_id(other_id)
        return result

    def find_by_book_id(self, other_id):
        self.read_file()
        result = self.__repo.find_by_book_id(other_id)
        return result

    def find_later_date(self, other_id, rented_date):
        self.read_file()
        result = self.__repo.find_later_date(other_id, rented_date)
        return result

    def add(self, rental):
        self.read_file()
        self.__repo.add(rental)
        self.write_file()

    def remove_rental_client(self, client_id):
        self.read_file()
        found_rentals = self.__repo.remove_rental_client(client_id)
        self.write_file()
        return found_rentals

    def remove_rental_book(self, book_id):
        self.read_file()
        found_rentals = self.__repo.remove_rental_book(book_id)
        self.write_file()
        return found_rentals

    def remove_rental_id(self, rental_id):
        self.read_file()
        rental = self.__repo.remove_rental_id(rental_id)
        self.write_file()
        return rental

    def update(self, book_id, returned_date):
        self.read_file()
        self.__repo.update(book_id, returned_date)
        self.write_file()

    def update_reverse(self, book_id, returned_date):
        self.read_file()
        last_rental = self.__repo.update_reverse(book_id, returned_date)
        self.write_file()
        return last_rental

from datetime import date
from time import strptime

from src.data_structure.data_structure import DataStructure
from src.domain.rental import Rental


class rentalRepoError(Exception):
    '''
    prints an exception related to the book class
    '''
    def __init__(self, msg):
        self._msg = msg

class RentalRepository:

    def __init__(self, rentals=None):
        '''
        creates the rental repository
        :param rentals: if we already have a rental list, otherwise none
        '''
        self._rentals = DataStructure()
        if rentals is not None:
            self.add_all(rentals)

    @property
    def rentals(self):
        '''
        returns the list of rentals
        :return: list of rentals - list type
        '''
        return self._rentals

    def add_all(self, rentals):
        '''
        adds a preexistent rental list
        :param rentals: the preexistent list
        :return:
        '''
        self._rentals = rentals

    def __len__(self):
        '''
        returns the length of the rental list
        :return: the length - int
        '''
        return len(self._rentals)

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
        for index in self._rentals:
            if self._rentals[index].rental_id == other_id:
                return self._rentals[index]

    def find_by_rental_id(self, other_id):
        '''
        finds rental by id
        :param other_id: the id we search, to see if it exists or not
        :return: 1 if the rental was found, 0 if not
        '''
        for index in self._rentals:
            if self._rentals[index].rental_id == other_id:
                return 1
        return 0

    def find_by_book_id(self, other_id):
        '''
        finds rental by book
        :param other_id: the id of the book we use to find rental
        :return: 0 if the book is not rented, 1 if the book is rented
        '''
        rented = 0
        for index in self._rentals:
            if self._rentals[index].book_id == other_id:
                if self._rentals[index].returned_date == '':
                    rented += 1
        if rented == 0:
            return 0
        return 1

    def find_later_date(self, other_id, rented_date):
        for index in self._rentals:
            if self._rentals[index].book_id == other_id:
                if isinstance(self._rentals[index].returned_date, date):
                    if rented_date < self._rentals[index].returned_date:
                        return 0
                if isinstance(self._rentals[index].returned_date, str):
                    if rented_date < date(self._rentals[index].returned_date):
                        return 0
        return 1

    def add(self, rental):
        '''
        add rental
        :param rental: rental id, client id, book id, rented date, returned date
        :return:
        '''
        self._rentals[rental.rental_id] = rental

    def remove_rental_client(self, client_id):
        found_rentals = []
        found = 0
        for index in self._rentals:
            if self._rentals[index].client_id == client_id:
                found += 1
        if found != 0:
            while found > 0:
                for index in self._rentals:
                    if self._rentals[index].client_id == client_id:
                        found_rentals.append(self._rentals[index])
                        del self._rentals[index]
                        found -= 1
                        break
        return found_rentals

    def remove_rental_book(self, book_id):
        found_rentals = []
        found = 0
        for index in self._rentals:
            if self._rentals[index].book_id == book_id:
                found += 1
        if found != 0:
            while found > 0:
                for index in self._rentals:
                    if self._rentals[index].book_id == book_id:
                        found_rentals.append(self._rentals[index])
                        del self._rentals[index]
                        found -= 1
                        break
        return found_rentals

    def remove_rental_id(self, rental_id):
        rental = self.find(rental_id)
        del self._rentals[rental_id]
        return rental

    def update(self, book_id, returned_date):
        returned = 1
        for index in self._rentals:
            if self._rentals[index].book_id == book_id:
                if self._rentals[index].returned_date == '':
                    self._rentals[index].returned_date = returned_date
                    returned = 0
        if returned == 1:
            raise rentalRepoError("This book has already been returned!")

    def update_reverse(self, book_id, returned_date):
        last_rental = None
        for index in self._rentals:
            if self._rentals[index].book_id == book_id:
                if self._rentals[index].returned_date != '':
                    last_rental = self._rentals[index]
        if last_rental != None:
            last_rental.returned_date = returned_date
        return last_rental

from datetime import date

from src.domain.book import Book, bookException
from src.domain.client import Client, clientException


class rentalException(Exception):
    '''
    prints an exception related to the rental class
    '''
    def __init__(self, msg):
        self._msg = msg


class Rental:

    def __init__(self, rental_id, client_id, book_id, rented_date, returned_date):
        '''
        defines a rental
        :param rental_id: id of the rental - unique and int!
        :param client_id: client id - client class
        :param book_id: book id - book class
        :param rented_date: the day the book was rented - date format
        :param returned_date: the day the book was returned - date format or empty string id the book was not returned
        '''

        self._rental_id = rental_id
        self._client_id = client_id
        self._book_id = book_id
        self._rented_date = rented_date
        self._returned_date = returned_date


    @property
    def rental_id(self):
        '''
        returns the rental id
        :return: the id of the rental - unique and int
        '''
        return self._rental_id

    @property
    def client_id(self):
        '''
        gets the id of the client
        :return: id of the client - int + client class
        '''
        return self._client_id

    @property
    def book_id(self):
        '''
        gets the id of the book
        :return: book id - int + book class
        '''
        return self._book_id

    @property
    def rented_date(self):
        '''
        gets the rented_date
        :return: the rented_date - date format
        '''
        return self._rented_date

    @property
    def returned_date(self):
        '''
        gets the returned_date
        :return: the returned_date - date format, empty string if book not returned
        '''
        return self._returned_date


    @returned_date.setter
    def returned_date(self, new_date):
        '''
        sets new returned date
        :param new_date: the new day of return
        :return:
        '''
        self._returned_date = new_date


    def __str__(self):
        '''
        transforms rental data to str
        :return: data in str
        '''
        return str(self._rental_id).rjust(4) + ' | ' + str(self._client_id).rjust(4) + ' | ' + str(
            self._book_id).rjust(4) + ' | ' + str(self._rented_date).rjust(4) + ' | ' + str(
            self._returned_date).rjust(4)


class RentalValidator:
    def validate(self, rental):
        '''
        validates rental data
        :param rental: entity from rental class
        :return:
        '''
        if isinstance(rental.rental_id, int) == False:
            raise rentalException('Rental ID must be an integer!')
        if rental.rental_id <= 0:
            raise rentalException('Rental ID cannot be a negative number!')
        if isinstance(rental.rented_date, date) == False:
            raise rentalException('Rented date must have date format!')
        if rental.returned_date != '':
            if isinstance(rental.returned_date, date) == False:
                raise rentalException("Returned date must have date format!")
            if rental.rented_date > rental.returned_date:
                raise rentalException('Returned date will always be later than the rented date!')



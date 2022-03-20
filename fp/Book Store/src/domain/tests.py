import unittest
from datetime import date

from src.domain.book import Book, BookValidator, bookException
from src.domain.client import Client, ClientValidator, clientException
from src.domain.rental import Rental, RentalValidator, rentalException


class TestBook(unittest.TestCase):
    def test_book(self):
        # verifies if the get functions work
        b = Book(1, 'Over the mountains', 'John Smith')
        bv = BookValidator()
        bv.validate(b)

    def test_book_with_errors(self):
        bv = BookValidator()
        self.assertRaises(bookException, bv.validate, Book(3.6, 'Sunset', 'Mary Jones'))
        self.assertRaises(bookException, bv.validate, Book(-98, 'Horizon', 'Mary Jones'))
        self.assertRaises(bookException, bv.validate, Book(8, '', 'Mary Jones'))
        self.assertRaises(bookException, bv.validate, Book(8, 'Horizon', ''))

    def test_setters(self):
        b = Book(1, 'Over the mountains', 'John Smith')
        bv = BookValidator()
        bv.validate(b)
        b.title = 'Under the sea'
        b.author = 'Mary Smith'
        self.assertEqual(b.title, 'Under the sea')
        self.assertEqual(b.author, 'Mary Smith')


class TestClient(unittest.TestCase):
    def test_client(self):
        # verifies if the get functions work
        c = Client(1, 'Popescu Ionel')
        cv = ClientValidator()
        cv.validate(c)

    def test_client_with_errors(self):
        cv = ClientValidator()
        self.assertRaises(clientException, cv.validate, Client(2.5, 'Costel Ionel'))
        self.assertRaises(clientException, cv.validate, Client(-4, 'Costel Ionel'))
        self.assertRaises(clientException, cv.validate, Client(2, ''))

    def test_setters(self):
        c = Client(1, 'Popescu Ionel')
        cv = ClientValidator()
        cv.validate(c)
        c.name = 'Popescu Georgel'
        self.assertEqual(c.name, 'Popescu Georgel')


class TestRental(unittest.TestCase):
    def test_rental(self):
        c = Client(2, 'Popescu Ionel')
        b = Book(4, 'Anna Karenina', 'Leo Tolstoy')
        r = Rental(1, c.client_id, b.book_id, date(2020, 10, 20), date(2020, 10, 25))
        rv = RentalValidator()
        rv.validate(r)
        self.assertEqual(r.client_id, 2)
        self.assertEqual(r.book_id, 4)

        # rental with book not returned yet
        c = Client(2, 'Popescu Ionel')
        b = Book(4, 'Anna Karenina', 'Leo Tolstoy')
        r = Rental(1, c.client_id, b.book_id, date(2020, 10, 20), '')
        rv = RentalValidator()
        rv.validate(r)

    def test_rental_with_errors(self):
        # invalid rental id
        c = Client(2, 'Popescu Ionel')
        b = Book(4, 'Anna Karenina', 'Leo Tolstoy')
        rv = RentalValidator()
        # invalid rental id
        self.assertRaises(rentalException, rv.validate, Rental(1.31, c.client_id, b.book_id, date(2020, 10, 20),
                                                               date(2020, 10, 25)))
        self.assertRaises(rentalException, rv.validate, Rental(-9, c.client_id, b.book_id, date(2020, 12, 2),
                                                               date(2020, 12, 4)))

        # rented date not in date format
        self.assertRaises(rentalException, rv.validate,
                          Rental(1, c.client_id, b.book_id, '2020/10/20', date(2020, 10, 25)))

        #returned date not in date format
        self.assertRaises(rentalException, rv.validate,
                          Rental(1, c.client_id, b.book_id, date(2020, 10, 25), '25/12/2020'))

        # rented date > returned date
        self.assertRaises(rentalException, rv.validate, Rental(1, c.client_id, b.book_id, date(2020, 10, 27),
                                                               date(2020, 10, 25)))

    def test_setters(self):
        c = Client(2, 'Popescu Ionel')
        b = Book(4, 'Anna Karenina', 'Leo Tolstoy')
        r = Rental(1, c.client_id, b.book_id, date(2020, 10, 20), '')
        rv = RentalValidator()
        rv.validate(r)
        r.returned_date = date(2020, 10, 22)
        self.assertEqual(r.returned_date, date(2020, 10, 22))

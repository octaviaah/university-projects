import json
import unittest
from datetime import date

from src.domain.book import Book
from src.domain.client import Client
from src.domain.rental import Rental
from src.repository.in_memory.book_repo import BookRepository, bookRepoError
from src.repository.in_memory.client_repo import ClientRepository, clientRepoError
from src.repository.in_memory.rental_repo import RentalRepository, rentalRepoError
from src.repository.json.book_json_repo import BookJSONRepository
from src.repository.json.client_json_repo import ClientJSONRepository
from src.repository.json.rental_json_repo import RentalJSONRepository
from src.repository.pickle.book_pickle_repo import BookPickleRepository
from src.repository.pickle.client_pickle_repo import ClientPickleRepository
from src.repository.pickle.rental_pickle_repo import RentalPickleRepository
from src.repository.text.book_text_repo import BookTextRepository
from src.repository.text.client_text_repo import ClientTextRepository
from src.repository.text.rental_text_repo import RentalTextRepository


class TestBookRepo(unittest.TestCase):
    def setUp(self):
        self._repo = BookRepository()
        self.assertEqual(len(self._repo), 0)

    def test_book_repo(self):
        self._repo.test_init()
        self.assertEqual(len(self._repo), 10)

        found = self._repo.find_by_id(1)
        self.assertEqual(found, 1)

        found = self._repo.find_by_id(14)
        self.assertEqual(found, 0)

        is_int = self._repo.is_integer('2.5')
        self.assertFalse(is_int)

        is_int = self._repo.is_integer('6')
        self.assertTrue(is_int)

    def test_add_all(self):
        books = [Book(1, 'One way', 'John Smith'), Book(2, 'Two ways', 'John Smith')]
        self._repo.add_all(books)
        self.assertEqual(len(self._repo), 2)

    def test_add(self):
        self._repo.add(Book(6, 'One way', 'John Smith'))
        self.assertEqual(len(self._repo), 1)

    def test_remove(self):
        self._repo.test_init()
        self.assertEqual(len(self._repo), 10)

        self._repo.add(Book(11, 'One way', 'John Smith'))
        self.assertEqual(len(self._repo), 11)
        book = self._repo.remove_id(11)
        self.assertEqual(book.book_id, 11)

        found_books = self._repo.remove_author('Leo Tolstoy')
        self.assertEqual(len(found_books), 2)

        self.assertRaises(bookRepoError, self._repo.remove_author, 'Octavia')

    def test_update(self):
        self._repo.test_init()
        self.assertEqual(len(self._repo), 10)

        self._repo.add(Book(11, 'One way', 'John Smith'))
        self.assertEqual(len(self._repo), 11)

        self._repo.update_title('One way', 'The Odyssey')
        self.assertEqual(self._repo.books[11].title, 'The Odyssey')

        self.assertRaises(bookRepoError, self._repo.update_title, 'Octavia', 'John')

        self._repo.update_author('John Smith', 'Johnny Smith')
        self.assertEqual(self._repo.books[11].author, 'Johnny Smith')

        self.assertRaises(bookRepoError, self._repo.update_author, 'Octavia', 'John')

    def test_search(self):
        self._repo.test_init()
        self.assertEqual(len(self._repo), 10)

        sorted_list = self._repo.search_id('1')
        self.assertEqual(len(sorted_list), 2)

        #negative id
        self.assertRaises(bookRepoError, self._repo.search_id, '-9')

        #id not int
        self.assertRaises(bookRepoError, self._repo.search_id, '2.56')

        sorted_list = self._repo.search_title('and P')
        self.assertEqual(len(sorted_list), 2)

        #empty string
        self.assertRaises(bookRepoError, self._repo.search_title, '')

        self._repo.add(Book(11, 'One way', 'Leo John'))
        self.assertEqual(len(self._repo), 11)

        sorted_list = self._repo.search_author('Leo')
        self.assertEqual(len(sorted_list), 3)

        #empty string
        self.assertRaises(bookRepoError, self._repo.search_author, '')


class TestClientRepo(unittest.TestCase):
    def setUp(self):
        self._repo = ClientRepository()
        self.assertEqual(len(self._repo), 0)

    def test_client_repo(self):
        self._repo.test_init()
        self.assertEqual(len(self._repo), 10)

        found = self._repo.find_by_id(1)
        self.assertEqual(found, 1)

        found = self._repo.find_by_id(65)
        self.assertEqual(found, 0)

        is_int = self._repo.is_integer('2.5')
        self.assertFalse(is_int)

        is_int = self._repo.is_integer('6')
        self.assertTrue(is_int)

    def test_add(self):
        self._repo.add(Client(7, 'Popescu Ion'))
        self.assertEqual(len(self._repo), 1)

    def test_add_all(self):
        clients = [Client(2, 'Popescu Ionel'), Client(2, 'Popescu Georgel')]
        self._repo.add_all(clients)
        self.assertEqual(len(self._repo), 2)

    def test_remove(self):
        self._repo.test_init()
        self.assertEqual(len(self._repo), 10)

        client = self._repo.remove(5)
        self.assertEqual(client.client_id, 5)

    def test_update(self):
        self._repo.test_init()
        self.assertEqual(len(self._repo), 10)

        self._repo.add(Client(11, 'John Smith'))
        self.assertEqual(len(self._repo), 11)

        self._repo.update('John Smith', 'Johnny')
        self.assertEqual(self._repo.clients[11].name, 'Johnny')

        self.assertRaises(clientRepoError, self._repo.update, 'Costel', 'Nelu')

    def test_search(self):
        self._repo.test_init()
        self.assertEqual(len(self._repo), 10)

        sorted_list = self._repo.search_id('1')
        self.assertEqual(len(sorted_list), 2)

        #id not int
        self.assertRaises(clientRepoError, self._repo.search_id, '5.02')

        #negative id
        self.assertRaises(clientRepoError, self._repo.search_id, '-8')

        sorted_list = self._repo.search_name('Ben')
        self.assertEqual(len(sorted_list), 2)

        #empty string
        self.assertRaises(clientRepoError, self._repo.search_name, '')


class TestRentalRepo(unittest.TestCase):
    def setUp(self):
        self._repo = RentalRepository()
        self.assertEqual(len(self._repo), 0)

    def test_rental_repo(self):
        rentals = {0: Rental(1, 2, 3, date(2020, 12, 6), ''), 1: Rental(3, 5, 7, date(2020, 10, 6), date(2020, 10, 17))}
        self._repo.add_all(rentals)
        self.assertEqual(len(self._repo), 2)

        # test find by rental id
        found = self._repo.find_by_rental_id(1)
        self.assertEqual(found, 1)

        found = self._repo.find_by_rental_id(6)
        self.assertEqual(found, 0)

        found = self._repo.find_by_book_id(3)
        self.assertEqual(found, 1)

        found = self._repo.find_by_book_id(9)
        self.assertEqual(found, 0)

        is_int = self._repo.is_integer('2.5')
        self.assertFalse(is_int)

        is_int = self._repo.is_integer('6')
        self.assertTrue(is_int)

        later_date = self._repo.find_later_date(7, date(2020, 10, 14))
        self.assertEqual(later_date, 0)

        later_date = self._repo.find_later_date(7, date(2020, 10, 31))
        self.assertEqual(later_date, 1)

    def test_add(self):
        self._repo.add(Rental(1, 2, 3, date(2020, 9, 2), date(2020, 9, 3)))
        self.assertEqual(len(self._repo), 1)

    def test_remove(self):
        self._repo.add(Rental(1, 2, 3, date(2020, 9, 2), date(2020, 9, 3)))
        self.assertEqual(len(self._repo), 1)

        found_rentals = self._repo.remove_rental_client(2)
        self.assertEqual(len(found_rentals), 1)

        self._repo.add(Rental(1, 2, 3, date(2020, 9, 2), date(2020, 9, 3)))
        self._repo.add(Rental(2, 4, 6, date(2020, 9, 4), date(2020, 9, 8)))
        self._repo.add(Rental(3, 5, 9, date(2020, 9, 9), date(2020, 9, 11)))

        rental = self._repo.remove_rental_id(2)
        self.assertEqual(rental.rental_id, 2)
        self.assertEqual(rental.client_id, 4)
        self.assertEqual(rental.book_id, 6)
        self.assertEqual(rental.rented_date, date(2020, 9, 4))
        self.assertEqual(rental.returned_date, date(2020, 9, 8))

        found_rentals = self._repo.remove_rental_book(3)
        self.assertEqual(len(found_rentals), 1)

    def test_update(self):
        self._repo.add(Rental(1, 2, 3, date(2020, 9, 2), ''))
        self.assertEqual(len(self._repo), 1)

        self._repo.update(3, date.today())
        self.assertEqual(self._repo.rentals[1].returned_date, date.today())

        self.assertRaises(rentalRepoError, self._repo.update, 3, date(2020, 1, 25))

        last_rental = self._repo.update_reverse(3, '')
        self.assertEqual(last_rental.book_id, 3)
        self.assertEqual(last_rental.returned_date, '')


class TestBookTextRepo(unittest.TestCase):
    def setUp(self):
        self._repo = BookTextRepository("D:/facultate/fp/a10-octaviaah/src/data/books.txt")
        self._repo.test_init()
        self.assertEqual(len(self._repo.books), 10)

        data = self._repo.read_file()
        self.assertEqual(len(data), 10)

    def test_book_text_repo(self):
        #file doesn't exist
        repo_error = BookTextRepository("dfghj.txt")
        self.assertRaises(IOError, repo_error.read_file)

        is_int = self._repo.is_integer('6')
        self.assertEqual(is_int, True)

        is_int = self._repo.is_integer('2.6')
        self.assertEqual(is_int, False)

        book = self._repo.find(6)
        self.assertEqual(book.book_id, 6)

        found = self._repo.find_by_id(9)
        self.assertEqual(found, 1)

        found = self._repo.find_by_id(147)
        self.assertEqual(found, 0)

    def test_text_add(self):
        self._repo.add(Book(25, 'Origins', 'John Smith'))
        self.assertEqual(self._repo.books[25].book_id, 25)
        self.assertEqual(self._repo.books[25].title, 'Origins')
        self.assertEqual(self._repo.books[25].author, 'John Smith')

        self._repo.remove_id(25)

    def test_text_remove(self):
        found_books = self._repo.remove_author('Leo Tolstoy')
        self.assertEqual(len(self._repo.books), 8)
        for book in found_books:
            self._repo.add(book)

        self._repo.add(Book(25, 'My Life', 'Popescu Ionel'))
        self.assertEqual(len(self._repo.books), 11)

        book = self._repo.remove_id(25)
        self.assertEqual(book.book_id, 25)

    def test_text_update(self):
        self._repo.add(Book(25, 'Origins', 'Johnny Smith'))
        self.assertEqual(len(self._repo.books), 11)

        self._repo.update_title('Origins', 'Popel')
        self.assertEqual(self._repo.books[25].title, 'Popel')

        self._repo.update_author('Johnny Smith', 'Popicel')
        self.assertEqual(self._repo.books[25].author, 'Popicel')

        self._repo.remove_id(25)

    def test_text_search(self):
        sorted_list = self._repo.search_id('1')
        self.assertEqual(len(sorted_list), 2)

        sorted_list = self._repo.search_title('the')
        self.assertEqual(len(sorted_list), 5)

        sorted_list = self._repo.search_author('leo')
        self.assertEqual(len(sorted_list), 2)


class TestClientTextRepo(unittest.TestCase):
    def setUp(self):
        self._repo = ClientTextRepository("D:/facultate/fp/a10-octaviaah/src/data/clients.txt")
        self._repo.test_init()
        self.assertEqual(len(self._repo.clients), 10)

        data = self._repo.read_file()
        self.assertEqual(len(data), 10)

    def test_client_text_repo(self):
        #file doesn't exist
        repo_error = ClientTextRepository("dfghj.txt")
        self.assertRaises(IOError, repo_error.read_file)

        is_int = self._repo.is_integer('6')
        self.assertEqual(is_int, True)

        is_int = self._repo.is_integer('2.6')
        self.assertEqual(is_int, False)

        client = self._repo.find(6)
        self.assertEqual(client.client_id, 6)

        found = self._repo.find_by_id(9)
        self.assertEqual(found, 1)

        found = self._repo.find_by_id(147)
        self.assertEqual(found, 0)

    def test_text_add(self):
        self._repo.add(Client(25, 'Popel Georgel'))
        self.assertEqual(self._repo.clients[25].client_id, 25)
        self.assertEqual(self._repo.clients[25].name, 'Popel Georgel')

        self._repo.remove(25)

    def test_text_remove(self):
        client = self._repo.remove(8)
        self.assertEqual(client.client_id, 8)

        self._repo.add(client)

    def test_text_update(self):
        self._repo.add(Client(25, 'Johnny Smith'))
        self.assertEqual(len(self._repo.clients), 11)

        self._repo.update('Johnny Smith', 'Popicel')
        self.assertEqual(self._repo.clients[25].name, 'Popicel')

        self._repo.remove(25)

    def test_text_search(self):
        sorted_list = self._repo.search_id('1')
        self.assertEqual(len(sorted_list), 2)

        sorted_list = self._repo.search_name('ll')
        self.assertEqual(len(sorted_list), 2)


class TestRentalTextRepo(unittest.TestCase):
    def setUp(self):
        self._repo = RentalTextRepository("D:/facultate/fp/a10-octaviaah/src/data/rentals.txt")
        self.assertEqual(len(self._repo), 0)

        self._repo.add(Rental(2, 3, 7, date(2020, 11, 30), date(2020, 12, 3)))
        self._repo.write_file()

        data = self._repo.read_file()
        self.assertEqual(len(data), 1)

    def test_rental_text_repo(self):
        #file doesn't exist
        repo_error = RentalTextRepository("dfghj.txt")
        self.assertRaises(IOError, repo_error.read_file)

        is_int = self._repo.is_integer('6')
        self.assertEqual(is_int, True)

        is_int = self._repo.is_integer('2.6')
        self.assertEqual(is_int, False)

        rental = self._repo.find(2)
        self.assertEqual(rental.rental_id, 2)

        found = self._repo.find_by_rental_id(9)
        self.assertEqual(found, 0)

        found = self._repo.find_by_book_id(147)
        self.assertEqual(found, 0)

        later_date = self._repo.find_later_date(7, date(2020, 10, 14))
        self.assertEqual(later_date, 0)

    def test_text_add(self):
        self._repo.add(Rental(25, 14, 258, date(2020, 11, 30), date(2020, 12, 2)))
        self.assertEqual(self._repo.rentals[25].rental_id, 25)
        self.assertEqual(self._repo.rentals[25].client_id, 14)
        self.assertEqual(self._repo.rentals[25].book_id, 258)
        self.assertEqual(self._repo.rentals[25].rented_date, str(date(2020, 11, 30)))
        self.assertEqual(self._repo.rentals[25].returned_date, str(date(2020, 12, 2)))

        self._repo.remove_rental_id(25)

    def test_text_remove(self):
        self._repo.add(Rental(25, 14, 258, date(2020, 11, 30), date(2020, 12, 2)))
        rental = self._repo.remove_rental_id(25)
        self.assertEqual(rental.rental_id, 25)

        self._repo.add(Rental(4, 4, 4, date(2020, 11, 30), date(2020, 12, 1)))
        found_rentals = self._repo.remove_rental_client(4)
        self.assertEqual(len(found_rentals), 1)

        self._repo.add(Rental(4, 4, 4, date(2020, 11, 30), date(2020, 12, 1)))
        found_rentals = self._repo.remove_rental_book(4)
        self.assertEqual(len(found_rentals), 1)

    def test_text_update(self):
        self._repo.add(Rental(288, 147, 10, date(2020, 11, 20), ''))

        self._repo.update(10, date(2020, 12, 5))
        self.assertEqual(self._repo.rentals[288].returned_date, str(date(2020, 12, 5)))

        last_rental = self._repo.update_reverse(10, '')
        self.assertEqual(last_rental.returned_date, '')

        self._repo.remove_rental_id(288)


class TestClientPickleRepo(unittest.TestCase):
    def setUp(self):
        self._repo = ClientPickleRepository("D:/facultate/fp/a10-octaviaah/src/data/clients.pickle")
        self._repo.test_init()
        self.assertEqual(len(self._repo.clients), 10)

        data = self._repo.read_binary_file()
        self.assertEqual(len(data), 10)

    def test_client_pickle_repo(self):
        #file doesn't exist
        repo_error = ClientPickleRepository("dfghj.pickle")
        self.assertRaises(IOError, repo_error.read_binary_file)

        is_int = self._repo.is_integer('6')
        self.assertEqual(is_int, True)

        is_int = self._repo.is_integer('2.6')
        self.assertEqual(is_int, False)

        client = self._repo.find(6)
        self.assertEqual(client.client_id, 6)

        found = self._repo.find_by_id(9)
        self.assertEqual(found, 1)

        found = self._repo.find_by_id(147)
        self.assertEqual(found, 0)

        repo_empty = ClientPickleRepository("D:/facultate/fp/a10-octaviaah/src/data/empty.txt")
        data = repo_empty.read_binary_file()
        self.assertEqual(data, [])

    def test_pickle_add(self):
        self._repo.add(Client(25, 'Popel Georgel'))
        self.assertEqual(self._repo.clients[25].client_id, 25)
        self.assertEqual(self._repo.clients[25].name, 'Popel Georgel')

        self._repo.remove(25)

    def test_pickle_remove(self):
        client = self._repo.remove(8)
        self.assertEqual(client.client_id, 8)

        self._repo.add(client)

    def test_pickle_update(self):
        self._repo.add(Client(25, 'Johnny Smith'))
        self.assertEqual(len(self._repo.clients), 11)

        self._repo.update('Johnny Smith', 'Popicel')
        self.assertEqual(self._repo.clients[25].name, 'Popicel')

        self._repo.remove(25)

    def test_pickle_search(self):
        sorted_list = self._repo.search_id('1')
        self.assertEqual(len(sorted_list), 2)

        sorted_list = self._repo.search_name('ll')
        self.assertEqual(len(sorted_list), 2)


class TestBookPickleRepo(unittest.TestCase):
    def setUp(self):
        self._repo = BookPickleRepository("D:/facultate/fp/a10-octaviaah/src/data/books.pickle")
        self._repo.test_init()
        self.assertEqual(len(self._repo.books), 10)

        data = self._repo.read_binary_file()
        self.assertEqual(len(data), 10)

    def test_book_pickle_repo(self):
        #file doesn't exist
        repo_error = BookPickleRepository("dfghj.pickle")
        self.assertRaises(IOError, repo_error.read_binary_file)

        is_int = self._repo.is_integer('6')
        self.assertEqual(is_int, True)

        is_int = self._repo.is_integer('2.6')
        self.assertEqual(is_int, False)

        book = self._repo.find(6)
        self.assertEqual(book.book_id, 6)

        found = self._repo.find_by_id(9)
        self.assertEqual(found, 1)

        found = self._repo.find_by_id(147)
        self.assertEqual(found, 0)

        repo_empty = BookPickleRepository("D:/facultate/fp/a10-octaviaah/src/data/empty.txt")
        data = repo_empty.read_binary_file()
        self.assertEqual(data, [])

    def test_pickle_add(self):
        self._repo.add(Book(25, 'Origins', 'John Smith'))
        self.assertEqual(self._repo.books[25].book_id, 25)
        self.assertEqual(self._repo.books[25].title, 'Origins')
        self.assertEqual(self._repo.books[25].author, 'John Smith')

        self._repo.remove_id(25)

    def test_pickle_remove(self):
        found_books = self._repo.remove_author('Leo Tolstoy')
        self.assertEqual(len(self._repo.books), 8)
        for book in found_books:
            self._repo.add(book)

        self._repo.add(Book(25, 'My Life', 'Popescu Ionel'))
        self.assertEqual(len(self._repo.books), 11)

        book = self._repo.remove_id(25)
        self.assertEqual(book.book_id, 25)

    def test_pickle_update(self):
        self._repo.add(Book(25, 'Origins', 'Johnny Smith'))
        self.assertEqual(len(self._repo.books), 11)

        self._repo.update_title('Origins', 'Popel')
        self.assertEqual(self._repo.books[25].title, 'Popel')
        self._repo.update_author('Johnny Smith', 'Popicel')
        self.assertEqual(self._repo.books[25].author, 'Popicel')

        self._repo.remove_id(25)

    def test_pickle_search(self):
        sorted_list = self._repo.search_id('1')
        self.assertEqual(len(sorted_list), 2)

        sorted_list = self._repo.search_title('the')
        self.assertEqual(len(sorted_list), 5)

        sorted_list = self._repo.search_author('leo')
        self.assertEqual(len(sorted_list), 2)


class TestRentalPickleRepo(unittest.TestCase):
    def setUp(self):
        self._repo = RentalPickleRepository("D:/facultate/fp/a10-octaviaah/src/data/rentals.pickle")
        self.assertEqual(len(self._repo), 0)

    def test_rental_pickle_repo(self):
        self._repo.add(Rental(2, 3, 7, date(2020, 11, 30), date(2020, 12, 3)))
        self._repo.write_binary_file()

        data = self._repo.read_binary_file()
        self.assertEqual(len(data), 1)

        #file doesn't exist
        repo_error = RentalPickleRepository("dfghj.pickle")
        self.assertRaises(IOError, repo_error.read_binary_file)

        is_int = self._repo.is_integer('6')
        self.assertEqual(is_int, True)

        is_int = self._repo.is_integer('2.6')
        self.assertEqual(is_int, False)

        rental = self._repo.find(2)
        self.assertEqual(rental.rental_id, 2)

        found = self._repo.find_by_rental_id(9)
        self.assertEqual(found, 0)

        found = self._repo.find_by_book_id(147)
        self.assertEqual(found, 0)

        later_date = self._repo.find_later_date(7, date(2020, 10, 14))
        self.assertEqual(later_date, 0)

        repo_empty = RentalPickleRepository("D:/facultate/fp/a10-octaviaah/src/data/empty.txt")
        data = repo_empty.read_binary_file()
        self.assertEqual(data, [])

        self._repo.remove_rental_id(2)

    def test_pickle_add(self):
        self._repo.add(Rental(25, 14, 258, date(2020, 11, 30), date(2020, 12, 2)))
        self.assertEqual(self._repo.rentals[25].rental_id, 25)
        self.assertEqual(self._repo.rentals[25].client_id, 14)
        self.assertEqual(self._repo.rentals[25].book_id, 258)
        self.assertEqual(self._repo.rentals[25].rented_date, date(2020, 11, 30))
        self.assertEqual(self._repo.rentals[25].returned_date, date(2020, 12, 2))

        self._repo.remove_rental_id(25)

    def test_pickle_remove(self):
        self._repo.add(Rental(25, 14, 258, date(2020, 11, 30), date(2020, 12, 2)))
        rental = self._repo.remove_rental_id(25)
        self.assertEqual(rental.rental_id, 25)

        self._repo.add(Rental(4, 4, 4, date(2020, 11, 30), date(2020, 12, 1)))
        found_rentals = self._repo.remove_rental_client(4)
        self.assertEqual(len(found_rentals), 1)

        self._repo.add(Rental(4, 4, 4, date(2020, 11, 30), date(2020, 12, 1)))
        found_rentals = self._repo.remove_rental_book(4)
        self.assertEqual(len(found_rentals), 1)

    def test_pickle_update(self):
        self._repo.add(Rental(288, 147, 10, date(2020, 11, 20), ''))

        self._repo.update(10, date(2020, 12, 5))
        self.assertEqual(self._repo.rentals[288].returned_date, date(2020, 12, 5))

        last_rental = self._repo.update_reverse(10, '')
        self.assertEqual(last_rental.returned_date, '')

        self._repo.remove_rental_id(288)


class TestClientJSONRepo(unittest.TestCase):
    def setUp(self):
        self._repo = ClientJSONRepository("D:/facultate/fp/a10-octaviaah/src/data/clients.json")
        self._repo.test_init()
        self.assertEqual(len(self._repo.clients), 10)

        data = self._repo.read_json_file()
        self.assertEqual(len(data), 10)

    def test_client_json_repo(self):
        #file doesn't exist
        repo_error = ClientJSONRepository("dfghj.json")
        self.assertRaises(IOError, repo_error.read_json_file)

        is_int = self._repo.is_integer('6')
        self.assertEqual(is_int, True)

        is_int = self._repo.is_integer('2.6')
        self.assertEqual(is_int, False)

        client = self._repo.find(6)
        self.assertEqual(client.client_id, 6)

        found = self._repo.find_by_id(9)
        self.assertEqual(found, 1)

        found = self._repo.find_by_id(147)
        self.assertEqual(found, 0)

        repo_empty = ClientJSONRepository("D:/facultate/fp/a10-octaviaah/src/data/empty.json")
        data = repo_empty.read_json_file()
        self.assertEqual(data, {})

    def test_json_add(self):
        self._repo.add(Client(25, 'Popel Georgel'))
        self.assertEqual(self._repo.clients[25].client_id, 25)
        self.assertEqual(self._repo.clients[25].name, 'Popel Georgel')

        self._repo.remove(25)

    def test_json_remove(self):
        client = self._repo.remove(8)
        self.assertEqual(client.client_id, 8)

        self._repo.add(client)

    def test_json_update(self):
        self._repo.add(Client(25, 'Johnny Smith'))
        self.assertEqual(len(self._repo.clients), 11)

        self._repo.update('Johnny Smith', 'Popicel')
        self.assertEqual(self._repo.clients[25].name, 'Popicel')

        self._repo.remove(25)

    def test_json_search(self):
        sorted_list = self._repo.search_id('1')
        self.assertEqual(len(sorted_list), 2)

        sorted_list = self._repo.search_name('ll')
        self.assertEqual(len(sorted_list), 2)


class TestBookJSONRepo(unittest.TestCase):
    def setUp(self):
        self._repo = BookJSONRepository("D:/facultate/fp/a10-octaviaah/src/data/books.json")
        self._repo.test_init()
        self.assertEqual(len(self._repo.books), 10)

        data = self._repo.read_json_file()
        self.assertEqual(len(data), 10)

    def test_book_json_repo(self):
        #file doesn't exist
        repo_error = BookJSONRepository("dfghj.json")
        self.assertRaises(IOError, repo_error.read_json_file)

        is_int = self._repo.is_integer('6')
        self.assertEqual(is_int, True)

        is_int = self._repo.is_integer('2.6')
        self.assertEqual(is_int, False)

        book = self._repo.find(6)
        self.assertEqual(book.book_id, 6)

        found = self._repo.find_by_id(9)
        self.assertEqual(found, 1)

        found = self._repo.find_by_id(147)
        self.assertEqual(found, 0)

        repo_empty = BookJSONRepository("D:/facultate/fp/a10-octaviaah/src/data/empty.json")
        data = repo_empty.read_json_file()
        self.assertEqual(data, {})

    def test_json_add(self):
        self._repo.add(Book(25, 'Origins', 'John Smith'))
        self.assertEqual(self._repo.books[25].book_id, 25)
        self.assertEqual(self._repo.books[25].title, 'Origins')
        self.assertEqual(self._repo.books[25].author, 'John Smith')
        self._repo.remove_id(25)

    def test_json_remove(self):
        found_books = self._repo.remove_author('Leo Tolstoy')
        self.assertEqual(len(self._repo.books), 8)
        for book in found_books:
            self._repo.add(book)

        self._repo.add(Book(25, 'My Life', 'Popescu Ionel'))
        self.assertEqual(len(self._repo.books), 11)

        book = self._repo.remove_id(25)
        self.assertEqual(book.book_id, 25)

    def test_json_update(self):
        self._repo.add(Book(25, 'Origins', 'Johnny Smith'))
        self.assertEqual(len(self._repo.books), 11)

        self._repo.update_title('Origins', 'Popel')
        self.assertEqual(self._repo.books[25].title, 'Popel')

        self._repo.update_author('Johnny Smith', 'Popicel')
        self.assertEqual(self._repo.books[25].author, 'Popicel')

        self._repo.remove_id(25)

    def test_json_search(self):
        sorted_list = self._repo.search_id('1')
        self.assertEqual(len(sorted_list), 2)

        sorted_list = self._repo.search_title('the')
        self.assertEqual(len(sorted_list), 5)

        sorted_list = self._repo.search_author('leo')
        self.assertEqual(len(sorted_list), 2)


class TestRentalJSONRepo(unittest.TestCase):
    def setUp(self):
        self._repo = RentalJSONRepository("D:/facultate/fp/a10-octaviaah/src/data/rentals.json")
        self.assertEqual(len(self._repo), 0)

    def test_rental_json_repo(self):
        self._repo.add(Rental(2, 3, 7, date(2020, 11, 30), date(2020, 12, 3)))
        self._repo.write_json_file()

        data = self._repo.read_json_file()
        self.assertEqual(len(data), 1)

        #file doesn't exist
        repo_error = RentalJSONRepository("dfghj.json")
        self.assertRaises(IOError, repo_error.read_json_file)

        is_int = self._repo.is_integer('6')
        self.assertEqual(is_int, True)

        is_int = self._repo.is_integer('2.6')
        self.assertEqual(is_int, False)

        rental = self._repo.find(2)
        self.assertEqual(rental.rental_id, 2)

        found = self._repo.find_by_rental_id(9)
        self.assertEqual(found, 0)

        found = self._repo.find_by_book_id(147)
        self.assertEqual(found, 0)

        later_date = self._repo.find_later_date(7, date(2020, 10, 14))
        self.assertEqual(later_date, 0)

        repo_empty = RentalJSONRepository("D:/facultate/fp/a9-octaviaah/src/data/empty.json")
        data = repo_empty.read_json_file()
        self.assertEqual(data, {})

        self._repo.remove_rental_id(2)

    def test_json_add(self):
        self._repo.add(Rental(25, 14, 258, date(2020, 11, 30), date(2020, 12, 2)))
        self.assertEqual(self._repo.rentals[25].rental_id, 25)
        self.assertEqual(self._repo.rentals[25].client_id, 14)
        self.assertEqual(self._repo.rentals[25].book_id, 258)
        self.assertEqual(self._repo.rentals[25].rented_date, str(date(2020, 11, 30)))
        self.assertEqual(self._repo.rentals[25].returned_date, str(date(2020, 12, 2)))

        self._repo.remove_rental_id(25)

    def test_json_remove(self):
        self._repo.add(Rental(25, 14, 258, date(2020, 11, 30), date(2020, 12, 2)))
        rental = self._repo.remove_rental_id(25)
        self.assertEqual(rental.rental_id, 25)

        self._repo.add(Rental(4, 4, 4, date(2020, 11, 30), date(2020, 12, 1)))
        found_rentals = self._repo.remove_rental_client(4)
        self.assertEqual(len(found_rentals), 1)

        self._repo.add(Rental(4, 4, 4, date(2020, 11, 30), date(2020, 12, 1)))
        found_rentals = self._repo.remove_rental_book(4)
        self.assertEqual(len(found_rentals), 1)

    def test_json_update(self):
        self._repo.add(Rental(288, 147, 10, date(2020, 11, 20), ''))

        self._repo.update(10, date(2020, 12, 5))
        self.assertEqual(self._repo.rentals[288].returned_date, str(date(2020, 12, 5)))

        last_rental = self._repo.update_reverse(10, '')
        self.assertEqual(last_rental.returned_date, '')

        self._repo.remove_rental_id(288)
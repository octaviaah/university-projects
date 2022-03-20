import unittest
from datetime import date

from src.repository.in_memory.book_repo import BookRepository
from src.repository.in_memory.client_repo import ClientRepository, clientRepoError
from src.repository.in_memory.rental_repo import RentalRepository
from src.service.book_service import BookService, bookServiceError
from src.service.client_service import ClientService, clientServiceError
from src.service.rental_service import RentalService, rentalServiceError
from src.service.undo_service import UndoService, FunctionCall, Operation, Cascade, undoServiceError


class TestBookService(unittest.TestCase):
    def setUp(self):
        self._repo = BookRepository()
        self._serv = BookService(self._repo)
        self._serv.repo.test_init()
        self.assertEqual(len(self._serv.repo), 10)

    def test_create_book(self):
        self._serv.create_book(11, 'One way', 'John Smith')
        self.assertEqual(len(self._serv.repo), 11)

        # add an already existing id
        self.assertRaises(bookServiceError, self._serv.create_book, 4, 'Two ways', 'John Smith')

    def test_remove_book(self):
        self._serv.create_book(11, 'One way', 'John Smith')
        self.assertEqual(len(self._serv.repo), 11)

        self._serv.remove_book(11, '')
        self.assertEqual(len(self._serv.repo), 10)

        self._serv.remove_book('', 'Leo Tolstoy')
        self.assertEqual(len(self._serv.repo), 8)

        # remove already removed book
        self.assertRaises(bookServiceError, self._serv.remove_book, 11, '')

        # remove with 2 attributes
        self.assertRaises(bookServiceError, self._serv.remove_book, 2, 'Anna Karenina')

        # remove with no attributes
        self.assertRaises(bookServiceError, self._serv.remove_book, '', '')

    def test_update_book(self):
        self._serv.create_book(11, 'One way', 'John Smith')
        self.assertEqual(len(self._serv.repo), 11)

        self._serv.update_book('One way', 'Anna', '', '')
        self.assertEqual(self._serv.repo.books[11].title, 'Anna')

        self._serv.update_book('', '', 'John Smith', 'Tom Smith')
        self.assertEqual(self._serv.repo.books[11].author, 'Tom Smith')

        # update more than two attributes
        self.assertRaises(bookServiceError, self._serv.update_book, 'Anna', 'Carol', 'John Smith', '')
        self.assertRaises(bookServiceError, self._serv.update_book, '', 'Anna', 'John Smith', '')

        # update, but all variables are None
        self.assertRaises(bookServiceError, self._serv.update_book, '', '', '', '')

        # title given, but no new title
        self.assertRaises(bookServiceError, self._serv.update_book, 'The Odyssey', '', '', '')

        # new title given, but no title
        self.assertRaises(bookServiceError, self._serv.update_book, '', 'The Odyssey', '', '')

        # author given, but no new author
        self.assertRaises(bookServiceError, self._serv.update_book, '', '', 'John', '')

        # no author, but new author given
        self.assertRaises(bookServiceError, self._serv.update_book, '', '', '', 'John')

    def test_search(self):
        sorted_list = self._serv.search_book('1', '', '')
        self.assertEqual(len(sorted_list), 2)

        sorted_list = self._serv.search_book('', 'the', '')
        self.assertEqual(len(sorted_list), 5)

        sorted_list = self._serv.search_book('', '', 'leo T')
        self.assertEqual(len(sorted_list), 2)

        # search more than 1 attribute
        self.assertRaises(bookServiceError, self._serv.search_book, '1', 'don', '')
        self.assertRaises(bookServiceError, self._serv.search_book, '', 'don', 'leo tol')

    def tearDown(self):
        print("good")


class TestClientService(unittest.TestCase):
    def setUp(self):
        self._repo = ClientRepository()
        self._serv = ClientService(self._repo)
        self._serv.repo.test_init()
        self.assertEqual(len(self._serv.repo), 10)

    def test_create_client(self):
        self._serv.create_client(11, 'Popescu Ionel')
        self.assertEqual(len(self._serv.repo), 11)

        # add an already existing id
        self.assertRaises(clientServiceError, self._serv.create_client, 4, 'Popescu Ionel')

    def test_remove_client(self):
        client = self._serv.remove_client(2)
        self.assertEqual(client.client_id, 2)

        client = self._serv.remove_client(4)
        self.assertEqual(client.client_id, 4)

        # remove already removed client
        self.assertRaises(clientServiceError, self._serv.remove_client, 2)

    def test_update_client(self):
        self._serv.create_client(11, 'Popescu Ionel')
        self.assertEqual(len(self._serv.repo), 11)

        self._serv.update_client('Popescu Ionel', 'Popescu Georgel')
        self.assertEqual(self._serv.repo.clients[11].name, 'Popescu Georgel')

        # empty name
        self.assertRaises(clientServiceError, self._serv.update_client, '', 'Popescu Georgel')

        # empty new name
        self.assertRaises(clientServiceError, self._serv.update_client, 'Popescu Ionel', '')

        # not str name
        self.assertRaises(clientServiceError, self._serv.update_client, 'Popescu Ionel', 25)

        # update nonexistent client
        self.assertRaises(clientRepoError, self._serv.update_client, 'Popescu Ionel', 'Popescu Georgel')

        # update client with nonexistent name
        self.assertRaises(clientRepoError, self._serv.update_client, 'Popescu Costel', 'Popescu Georgel')

    def test_search_client(self):
        sorted_list = self._serv.search_client('1', '')
        self.assertEqual(len(sorted_list), 2)

        sorted_list = self._serv.search_client('', 'John')
        self.assertEqual(len(sorted_list), 3)

        # search by two elements
        self.assertRaises(clientServiceError, self._serv.search_client, '5', 'John')

    def tearDown(self):
        print("good")


class TestRentalService(unittest.TestCase):
    def setUp(self):
        self._repo = RentalRepository()
        self._serv = RentalService(self._repo)

    def test_create_rental(self):
        self._serv.create_rental(11, 2, 11, date(2020, 10, 1), '')
        self.assertEqual(len(self._serv.repo), 1)

        # duplicate rental id
        self.assertRaises(rentalServiceError, self._serv.create_rental, 11, 6, 14, date(2020, 9, 16), '')

        # book already rented
        self.assertRaises(rentalServiceError, self._serv.create_rental, 12, 5, 11, date(2020, 11, 2), '')

        # rented date later than today
        self.assertRaises(rentalServiceError, self._serv.create_rental, 2, 1, 13, date(2020, 12, 25), '')

        # rented date earlier than last returned date
        self._serv.update_rental(11, date(2020, 11, 28))
        self.assertRaises(rentalServiceError, self._serv.create_rental, 17, 2, 11, date(2020, 8, 17), '')

    def test_update_rental(self):
        self._serv.create_rental(11, 2, 11, date(2020, 10, 1), '')
        self.assertEqual(len(self._serv.repo), 1)

        self._serv.update_rental(11, date(2020, 10, 6))
        self.assertEqual(self._serv.repo.rentals[11].returned_date, date(2020, 10, 6))

        # book already returned
        self.assertRaises(rentalServiceError, self._serv.update_rental, 11, date(2020, 10, 15))

    def test_most_rented_books(self):
        b = BookRepository()
        b.test_init()
        self._serv.create_rental(1, 1, 2, date(2020, 10, 1), '')
        self._serv.create_rental(2, 1, 3, date(2020, 10, 2), '')
        self._serv.update_rental(3, date(2020, 10, 5))
        self._serv.create_rental(3, 5, 3, date(2020, 10, 7), '')

        top_books = self._serv.most_rented_books(b)
        self.assertEqual(top_books[0][1], 2)
        self.assertEqual(top_books[1][1], 1)

    def test_most_active_clients(self):
        c = ClientRepository()
        c.test_init()
        self._serv.create_rental(1, 1, 2, date(2020, 10, 1), '')
        self._serv.create_rental(2, 1, 3, date(2020, 10, 2), '')
        self._serv.update_rental(3, date(2020, 10, 5))
        self._serv.create_rental(3, 5, 3, date(2020, 10, 7), '')
        self._serv.update_rental(3, date.today())
        self._serv.create_rental(4, 1, 6, date(2020, 10, 8), '')
        self._serv.create_rental(5, 5, 8, date(2020, 10, 10), '')

        top_clients = self._serv.most_active_clients(c)
        self.assertGreaterEqual(top_clients[0][1], 132)
        self.assertGreaterEqual(top_clients[1][1], 121)

    def test_most_rented_authors(self):
        b = BookRepository()
        b.test_init()
        self._serv.create_rental(1, 1, 2, date(2020, 10, 1), '')
        self._serv.create_rental(2, 1, 3, date(2020, 10, 2), '')
        self._serv.update_rental(3, date(2020, 10, 5))
        self._serv.create_rental(3, 5, 3, date(2020, 10, 7), '')

        top_books_authored = self._serv.most_rented_author(b)
        self.assertGreater(top_books_authored[0][0][3], 1)

    def tearDown(self):
        print("good")


class TestUndoService(unittest.TestCase):
    def setUp(self):
        self._client_repo = ClientRepository()
        self._client_serv = ClientService(self._client_repo)
        self._client_serv.repo.test_init()

    def test_function_call(self):
        self._client_serv.create_client(11, 'Popel')

        undo = FunctionCall(self._client_serv.remove_client, 11)
        self.assertEqual(undo._ref, self._client_serv.remove_client)
        self.assertEqual(undo._params, (11, ))

        redo = FunctionCall(self._client_serv.create_client, 11, 'Popel')
        self.assertEqual(redo._ref, self._client_serv.create_client)
        self.assertEqual(redo._params, (11, 'Popel'))

        undo.call()
        self.assertEqual(len(self._client_serv.repo), 10)

        redo.call()
        self.assertEqual(len(self._client_serv.repo), 11)

    def test_operation(self):
        self._client_serv.create_client(11, 'Popel')
        undo = FunctionCall(self._client_serv.remove_client, 11)
        redo = FunctionCall(self._client_serv.create_client, 11, 'Popel')

        operation = Operation(undo, redo)
        self.assertEqual(operation._call_undo, undo)
        self.assertEqual(operation._call_redo, redo)

        operation.undo()
        self.assertEqual(len(self._client_serv.repo), 10)

        operation.redo()
        self.assertEqual(len(self._client_serv.repo), 11)

    def test_cascade(self):
        self._client_serv.create_client(11, 'Popel')
        undo = FunctionCall(self._client_serv.remove_client, 11)
        redo = FunctionCall(self._client_serv.create_client, 11, 'Popel')
        operation = Operation(undo, redo)
        cascade_list = [operation]

        self._client_serv.create_client(12, 'Dodo')
        undo = FunctionCall(self._client_serv.remove_client, 12)
        redo = FunctionCall(self._client_serv.create_client, 12, 'Dodo')
        operation = Operation(undo, redo)
        cascade_list.append(operation)

        cop = Cascade(*cascade_list)
        self.assertEqual(cop._operations, tuple(cascade_list))

        cop.undo()
        self.assertEqual(len(self._client_serv.repo), 10)

        cop.redo()
        self.assertEqual(len(self._client_serv.repo), 12)

    def test_undo_service(self):
        self._undo_serv = UndoService()
        self._client_serv.create_client(11, 'Popel')
        undo = FunctionCall(self._client_serv.remove_client, 11)
        redo = FunctionCall(self._client_serv.create_client, 11, 'Popel')
        operation = Operation(undo, redo)
        cascade_list = [operation]
        cop = Cascade(*cascade_list)

        self._undo_serv.record(cop)
        self.assertEqual(len(self._undo_serv._history), 1)
        self.assertEqual(self._undo_serv._index, 0)

        self._undo_serv.undo()
        self.assertEqual(self._undo_serv._index, -1)

        #no more undos
        self.assertRaises(undoServiceError, self._undo_serv.undo)

        self._undo_serv.redo()
        self.assertEqual(self._undo_serv._index, 0)

        #no more redos
        self.assertRaises(undoServiceError, self._undo_serv.redo)
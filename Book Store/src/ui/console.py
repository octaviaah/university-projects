from datetime import date

from src.domain.book import bookException
from src.domain.client import clientException
from src.domain.rental import rentalException
from src.repository.in_memory.book_repo import bookRepoError
from src.repository.in_memory.client_repo import clientRepoError
from src.repository.in_memory.rental_repo import rentalRepoError, RentalRepository
from src.service.book_service import BookService, bookServiceError
from src.service.client_service import ClientService, clientServiceError
from src.service.rental_service import RentalService, rentalServiceError
from src.service.undo_service import UndoService, FunctionCall, Operation, Cascade, undoServiceError


class ui:
    def __init__(self, cr, br, rr):
        self._undo_serv = UndoService()
        self._client_repo = cr
        self._client_serv = ClientService(self._client_repo)
        self._book_repo = br
        self._book_serv = BookService(self._book_repo)
        self._rental_repo = rr
        self._rental_serv = RentalService(self._rental_repo)

    def read_client_for_add(self):
        client_id = input("enter client id: ")
        if self._client_serv.repo.is_integer(client_id) == False:
            raise clientServiceError("ID must have an integer value!")
        if int(client_id) <=0:
            raise clientServiceError("Client ID cannot be a negative number!")
        if self._client_serv.repo.find_by_id(int(client_id)) == 1:
            raise clientServiceError("Duplicate ID!")
        name = input("enter client name: ")

        self._client_serv.create_client(int(client_id), name)
        print('Client added!')

        undo = FunctionCall(self._client_serv.remove_client, int(client_id))
        redo = FunctionCall(self._client_serv.create_client, int(client_id), name)
        operation = Operation(undo, redo)
        self._undo_serv.record(operation)

    def read_client_for_remove(self):
        client_id = input('enter client id: ')
        if self._client_serv.repo.is_integer(client_id) is False:
            raise clientServiceError("ID must have an integer value!")
        if int(client_id) <= 0:
            raise clientServiceError("Client ID cannot be a negative number!")

        client = self._client_serv.remove_client(int(client_id))
        found_rentals = self._rental_repo.remove_rental_client(int(client_id))
        if client != None:
            print('Client removed!')

        undo = FunctionCall(self._client_serv.create_client, int(client_id), client.name)
        redo = FunctionCall(self._client_serv.remove_client, int(client_id))
        operation = Operation(undo, redo)
        cascade_list = [operation]
        for rental in found_rentals:
            undo = FunctionCall(self._rental_serv.create_rental, rental.rental_id, rental.client_id, rental.book_id,
                                rental.rented_date, rental.returned_date)
            redo = FunctionCall(self._rental_repo.remove_rental_id, rental.rental_id)
            cascade_list.append(Operation(undo, redo))

        cop = Cascade(*cascade_list)
        self._undo_serv.record(cop)

    def read_client_for_update(self):
        name = input('enter client name: ')
        new_name = input('enter new name for client: ')

        self._client_serv.update_client(name, new_name)
        print('Client updated!')

        undo = FunctionCall(self._client_serv.update_client, new_name, name)
        redo = FunctionCall(self._client_serv.update_client, name, new_name)
        operation = Operation(undo, redo)
        self._undo_serv.record(operation)

    def read_client_for_search(self):
        client_id = input('enter client id: ')
        name = input('enter client name: ')

        sorted_list = self._client_serv.search_client(client_id, name)
        if len(sorted_list) == 0:
            print('No client was found!')
        else:
            for element in sorted_list:
                print(str(element))

    def list_clients(self):
        for client in self._client_serv.repo.clients.values():
            print(str(client))

    def read_book_for_add(self):
        book_id = input("enter book id: ")
        if self._book_serv.repo.is_integer(book_id) is False:
            raise bookServiceError("ID must be an integer value!")
        if int(book_id) <= 0:
            raise bookServiceError("Book ID cannot be a negative number!")
        if self._book_serv.repo.find_by_id(int(book_id)) == 1:
            raise bookServiceError("Duplicate ID!")
        title = input('enter book title: ')
        author = input('enter book author: ')

        self._book_serv.create_book(int(book_id), title, author)
        print('Book added!')

        undo = FunctionCall(self._book_serv.repo.remove_id, int(book_id))
        redo = FunctionCall(self._book_serv.create_book, int(book_id), title, author)
        operation = Operation(undo, redo)
        self._undo_serv.record(operation)

    def read_book_for_remove(self):
        book_id = input('enter book id: ')
        if book_id != '':
            if self._book_serv.repo.is_integer(book_id) is False:
                raise bookServiceError("ID must be an integer value!")
            if int(book_id) <= 0:
                raise bookServiceError("Book ID cannot be a negative number!")
        author = input('enter book author: ')

        if book_id == '':
            found_books = self._book_serv.remove_book('', author)
            print('Book removed!')

            cascade_list = []
            for book in found_books:
                undo = FunctionCall(self._book_serv.create_book, int(book.book_id), book.title, book.author)
                redo = FunctionCall(self._book_serv.repo.remove_id, int(book.book_id))
                cascade_list.append(Operation(undo, redo))
                found_rentals = self._rental_repo.remove_rental_book(book.book_id)
                for rental in found_rentals:
                    undo = FunctionCall(self._rental_serv.create_rental, rental.rental_id, rental.client_id,
                                        rental.book_id, rental.rented_date, rental.returned_date)
                    redo = FunctionCall(self._rental_repo.remove_rental_book, rental.book_id)
                    cascade_list.append(Operation(undo, redo))
        else:
            book = self._book_serv.remove_book(int(book_id), author)
            found_rentals = self._rental_repo.remove_rental_book(int(book_id))
            print("Book removed!")

            undo = FunctionCall(self._book_serv.create_book, int(book.book_id), book.title, book.author)
            redo = FunctionCall(self._book_serv.repo.remove_id, int(book.book_id))
            cascade_list = [Operation(undo, redo)]
            for rental in found_rentals:
                undo = FunctionCall(self._rental_serv.create_rental, rental.rental_id, rental.client_id,
                                    rental.book_id, rental.rented_date, rental.returned_date)
                redo = FunctionCall(self._rental_repo.remove_rental_book, rental.book_id)
                cascade_list.append(Operation(undo, redo))

        cop = Cascade(*cascade_list)
        self._undo_serv.record(cop)

    def read_book_for_update(self):
        title = input('enter book title: ')
        new_title = input('enter new title for book: ')
        author =  input('enter book author: ')
        new_author = input('enter new author for book: ')

        self._book_serv.update_book(title, new_title, author, new_author)
        print('Book updated!')

        if title == '' and new_title == '':
            undo = FunctionCall(self._book_serv.repo.update_author, new_author, author)
            redo = FunctionCall(self._book_serv.repo.update_author, author, new_author)
        else:
            undo = FunctionCall(self._book_serv.repo.update_title, new_title, title)
            redo = FunctionCall(self._book_serv.repo.update_title, title, new_title)

        operation = Operation(undo, redo)
        self._undo_serv.record(operation)

    def read_book_for_search(self):
        book_id = input('enter book id: ')
        title = input('enter book title: ')
        author = input('enter book author: ')

        sorted_list = self._book_serv.search_book(book_id, title, author)
        if len(sorted_list) == 0:
            print('No book was found!')
        else:
            for element in sorted_list:
                print(str(element))

    def list_books(self):
        for book in self._book_serv.repo.books.values():
            print(str(book))

    def rent_a_book(self):
        length = len(self._rental_repo)

        client_id = input('enter client id: ')
        if self._rental_serv.repo.is_integer(client_id) is False:
            raise rentalServiceError("ID must be an integer value!")
        if int(client_id) <= 0:
            raise rentalServiceError("Client ID cannot be a negative number!")
        if self._client_serv.repo.find_by_id(int(client_id)) == 0:
            raise rentalServiceError("Client does not exist!")

        book_id = input('enter book id: ')
        if self._rental_serv.repo.is_integer(book_id) is False:
            raise rentalServiceError("ID must be an integer value!")
        if int(book_id) <= 0:
            raise rentalServiceError("Book ID cannot be a negative number!")
        if self._book_serv.repo.find_by_id(int(book_id)) == 0:
            raise rentalServiceError("Book does not exist!")

        day = input('enter rental day: ')
        if self._rental_serv.repo.is_integer(day) is False:
            raise rentalServiceError("Rental day must be an integer!")
        if int(day) < 1 or int(day) > 31:
            raise rentalServiceError("Rental day must be between 1 and 31!")

        month = input('enter rental month in numbers: ')
        if self._rental_serv.repo.is_integer(month) is False:
            raise rentalServiceError("Rental month must be an integer!")
        if int(month) < 1 or int(month) > 12:
            raise rentalServiceError("Rental month must be between 1 and 12!")

        self._rental_serv.create_rental(length+1, int(client_id), int(book_id), date(2020, int(month), int(day)), '')
        print("Book rented!")

        undo = FunctionCall(self._rental_serv.repo.remove_rental_id, length+1)
        redo = FunctionCall(self._rental_serv.create_rental, length+1, int(client_id), int(book_id), date(2020, int(month),
                                                                                                          int(day)), '')

        operation = Operation(undo, redo)
        self._undo_serv.record(operation)

    def return_a_book(self):
        book_id = input("enter book id of the book to return: ")
        if self._rental_serv.repo.is_integer(book_id) is False:
            raise rentalServiceError("ID must be an integer value!")
        if int(book_id) <= 0:
            raise rentalServiceError("Book ID cannot be a negative number!")
        returned_date = date.today()

        self._rental_serv.update_rental(int(book_id), returned_date)
        print("Book returned!")

        undo = FunctionCall(self._rental_serv.repo.update_reverse, int(book_id), '')
        redo = FunctionCall(self._rental_serv.update_rental, int(book_id), returned_date)

        operation = Operation(undo, redo)
        self._undo_serv.record(operation)

    def list_rentals(self):
        for rental in self._rental_repo.rentals.values():
            print(str(rental))

    def print_most_rented_books(self):
        top_books = self._rental_serv.most_rented_books(self._book_repo)
        print('The most rented books are:')
        index = 1
        for book in top_books:
            print(str(index) + '.  ' + book[0] + ' -> ' + str(book[1]) + ' times')
            index += 1

    def print_most_active_clients(self):
        top_clients = self._rental_serv.most_active_clients(self._client_repo)
        print('The most active clients are:')
        index = 1
        for client in top_clients:
            print(str(index) + '.  ' + client[0] + ' -> ' + str(client[1]) + ' days')
            index +=1

    def print_most_rented_author(self):
        top_books_authored = self._rental_serv.most_rented_author(self._book_repo)
        print('The most rented author is ' + top_books_authored[0][0][2] + ' and their books were rented ' +
              str(top_books_authored[0][0][3]) + ' times. The list of books authored by ' + top_books_authored[0][0][
                  2] + ' are: ')
        index = 1
        for author in top_books_authored:
            for book in author:
                print(str(index) + '.  ' + book[0] + ' -> ' + str(book[1]) + ' times')
                index += 1

    def undo_action(self):
        self._undo_serv.undo()
        print("Undo done!")

    def redo_action(self):
        self._undo_serv.redo()
        print("Redo done!")


    def print_menu(self):
        print("Choose a command:")
        print('CLIENT commands: ')
        print("\ta - add client")
        print("\tb - remove client")
        print("\tc - update client")
        print("\td - list clients")
        print('\te - search client')
        print('BOOK commands: ')
        print('\tf - add book')
        print('\tg - remove book')
        print('\th - update book')
        print('\ti - list books')
        print('\tj - search book')
        print('RENTAL commands: ')
        print('\tk - rent book')
        print('\tl - return book')
        print('\tm - list rentals')
        print('STATISTICS commands: ')
        print('\tn - most rented books')
        print('\to - most active clients')
        print('\tp - books authored for most rented author')
        print('UNDO\REDO')
        print('\tu - undo last action')
        print('\tr - redo last action')
        print('x - exit')

    def start(self):

        self._client_serv.repo.test_init()
        self._book_serv.repo.test_init()

        command_dict = {'a': self.read_client_for_add, 'b': self.read_client_for_remove,
                        'c':self.read_client_for_update, 'd': self.list_clients, 'e': self.read_client_for_search, 'f':
                            self.read_book_for_add,
                        'g': self.read_book_for_remove, 'h': self.read_book_for_update, 'i': self.list_books,
                        'j': self.read_book_for_search,
                        'k': self.rent_a_book, 'l': self.return_a_book, 'm': self.list_rentals,
                        'n':self.print_most_rented_books, 'o': self.print_most_active_clients,
                        'p': self.print_most_rented_author, 'u': self.undo_action, 'r': self.redo_action}

        self.print_menu()

        done = False

        while not done:
            command = input('insert command: ')
            command = command.lower()
            if command in command_dict:
                try:
                    command_dict[command]()
                except (clientServiceError, clientException, clientRepoError, bookServiceError, bookException,
                        bookRepoError, rentalServiceError, rentalException, rentalRepoError, undoServiceError,
                        ValueError) as e:
                    print(str(e))
            elif command == 'x':
                print("Goodbye!")
                done = True
            else:
                print('invalid command')


#menu_ui = ui(ClientRepository(), BookRepository(), RentalRepository())
#menu_ui.start()
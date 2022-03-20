from collections import Counter
from datetime import date
from functools import reduce

from src.data_structure.data_structure import gnome_sort, filter
from src.domain.rental import Rental, RentalValidator

class rentalServiceError(Exception):
    '''
    prints an exception related to the rental service class
    '''
    def __init__(self, msg):
        self._msg = msg

class RentalService:
    def __init__(self, repo):
        '''
        gets the repo from rental repo
        :param repo: the rental repo(or other existent rental repo) - list of rentals + functions related to it
        '''
        self._repo = repo

    @property
    def repo(self):
        '''
        returns the repo
        :return: the repo - list of rentals + functions related to it
        '''
        return self._repo

    def create_rental(self, rental_id, client_id, book_id, rented_date, returned_date):
        '''
        adds rental to the list
        :param rental_id:  id of the rental - unique + int
        :param client_id: id of the client who rented book - client class
        :param book_id: id of the book rented - book class
        :param rented_date: the day the book was rented - date format
        :return:
        '''
        if self._repo.find_by_rental_id(rental_id) == 1:
            raise rentalServiceError("Duplicate rental ID!")
        if self._repo.find_by_book_id(book_id) == 1:
            raise rentalServiceError("Book already rented!")
        if rented_date > date.today():
            raise rentalServiceError("Rented date must be a date before " + str(date.today()) + "!")
        if self._repo.find_later_date(book_id, rented_date) == 0:
            raise rentalServiceError("You can't rent a book on a date earlier than the last time it was returned!")

        new_rental = Rental(rental_id, client_id, book_id, rented_date, returned_date)
        rv = RentalValidator()
        rv.validate(new_rental)
        self._repo.add(new_rental)

    def update_rental(self, book_id, returned_date):
        '''
        updates returned_date
        :param book_id: the id of the book where we update the returned_date - int
        :param returned_date: the new returned date - date format
        :return:
        '''
        if self._repo.find_by_book_id(book_id) == 0:
            raise rentalServiceError("Book has not been rented yet!")
        self._repo.update(book_id, returned_date)

    def most_rented_books(self, repo):
        '''
        creates a list in reverse, based on the number of times a book was rented
        top contains the book ids of books rented
        counter calculated the number of times each book was rented
        in top books we add the book object and its corresponding number of rentals
        :param repo: the book repo(or any other repo that contains information related to books)
        :return: the list of most rented books - book title -> times the book was rented
        '''
        top = list(map(lambda rental: rental.book_id, self._repo.rentals.values()))

        c = Counter(top)
        top_books = list(map(lambda book: [book.title, 0 if book.book_id not in c.keys() else c[book.book_id]],
                             repo.books.values()))
        top_books = gnome_sort(top_books, comparator=lambda x, y: x[1] >= y[1])
        return top_books

    def days_for_book(self, start_date, final_date):
        '''
        calculates the number between the day a book was rented and the day a book was returned
        :param start_date: the day a book was rented
        :param final_date: return day of a book, date.today if book was not returned
        :return: number of days between start date and final date
        '''
        if final_date == '':
            final_date = date.today()
        return (final_date - start_date).days

    def most_active_clients(self, repo):
        '''
        creates a list in reverse, based on the number of days a client has owned books
        top days contains the list of book, along with the number of days it was rented each time(a book can appear
        more times)
        counter calculates the number of times each book was rented
        merged list merges books that appear multiple times into one element, and sums the numbers of days the book
        was rented
        top active clients stores the list of clients, along with the number of days they have owned books
        :param repo: the client repo(or any other repo that contains information related to clients)
        :return: the list of most active clients - client name -> number of days they have owned books
        '''
        top_days = list(map(lambda rental: [rental.client_id, abs(self.days_for_book(rental.rented_date,
                                                                                     rental.returned_date))],
                            self._repo.rentals.values()))
        top_days.sort(key=lambda x: x[0])

        c = Counter([x[0] for x in top_days])
        merged_list = list(list(filter(lambda x: x[0] == client_id, top_days)) for client_id in c.keys())
        merged_list = list(map(lambda x: reduce(lambda a, b: [a[0], b[1] + a[1]], x), merged_list))

        c = {x[0]: x[1] for x in merged_list}
        top_active_clients = list(map(lambda client: [client.name, 0 if client.client_id not in c.keys() else c[
            client.client_id]], repo.clients.values()))
        top_active_clients = gnome_sort(top_active_clients, comparator=lambda x, y : x[1] >= y[1])
        return top_active_clients

    def most_rented_author(self, repo):
        '''
        creates a list in reverse, that contains the books authored by the most rented author and the number of times their books were rented
        top books stores the list with the most rented books
        top stores the book ids of books rented
        counter calculates the number of times a book was rented
        top books with authors creates a relation between author and books rented (all authors will be stored)
        second counter counts the number of times each author appears in top_books_with_authors
        top authors merges authors that appear more than once and sums the number of times their books were rented
        top books authored stores the title of books authored along with number of times they were rented for most
        rented author
        :param repo: book repo or other repo that has functionalities related to books
        :return: the books authored for most rented author - book title -> no of times book was rented + author + no
        of times author was rented
        '''
        top_books = self.most_rented_books(repo)

        top = list(map(lambda rental: rental.book_id, self._repo.rentals.values()))

        c = Counter(top)
        top_books_with_authors = list(map(lambda book: [book.author, 0 if book.book_id not in c.keys() else c[
            book.book_id]], repo.books.values()))
        top_books_with_authors.sort(key=lambda x:x[0])

        c = Counter([x[0] for x in top_books_with_authors])
        top_authors = list(list(filter(lambda x: x[0] == author, top_books_with_authors)) for author in c.keys())
        top_authors = list(map(lambda x: reduce(lambda a, b: [a[0], b[1] + a[1]], x), top_authors))
        top_authors = gnome_sort(top_authors, comparator=lambda x, y: x[1] >= y[1])

        c ={top_authors[0][0]: top_authors[0][1]}
        d ={y[0]: y[1] for y in top_books}

        top_books_authored = list(map(lambda book: [book.title, d[book.title], book.author if book.author in c.keys()
        else None, c[book.author] if book.author in c.keys() else 0], repo.books.values()))
        top_books_authored = list(list(filter(lambda x: x[2] == author, top_books_authored)) for author in
                                            c.keys())
        top_books_authored[0] = gnome_sort(top_books_authored[0], comparator=lambda x, y: x[1] >= y[1])
        return top_books_authored



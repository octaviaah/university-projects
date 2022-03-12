from random import choice

from src.data_structure.data_structure import DataStructure, filter, gnome_sort
from src.domain.book import Book


class bookRepoError(Exception):
    '''
    prints an exception related to the book class
    '''
    def __init__(self, msg):
        self._msg = msg


class BookRepository:

    def __init__(self, books=None):
        '''
        creates book repository
        :param books: if we already have a book list, otherwise none
        '''
        self._books = DataStructure()
        if books is not None:
            self.add_all(books)

    @property
    def books(self):
        '''
        returns the list of books
        :return: the list of books - list type
        '''
        return self._books

    def __len__(self):
        '''
        returns the length of the book list
        :return: the length - int
        '''
        return len(self._books)

    def add_all(self, books):
        self._books = books

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
        for index in self._books:
            if self._books[index].book_id == other_id:
                return self._books[index]

    def find_by_id(self, other_id):
        '''
        finds book by id
        :param other_id: the id of the book to be found
        :return: 1 if the book was found, 0 otherwise
        '''
        for index in self._books:
            if self._books[index].book_id == other_id:
                return 1
        return 0

    def add(self, book):
        '''
        adds book to the book list
        :param book: the book - book id, title, author
        :return:
        '''
        self._books[book.book_id] = book

    def remove_id(self, book_id):
        '''
        remove book from the list by book id
        :param book_id: the id of the book - int
        :return: book entity(for undo/redo)
        '''
        book = self.find(book_id)
        del self._books[book_id]
        return book

    def remove_author(self, author):
        '''
        removes book by author
        :param author: the author of the book - str,
        :return:
        '''
        found = 0
        found_books = []
        for index in self._books:
            if self._books[index].author == author:
                found += 1
        if found == 0:
            raise bookRepoError("No book with given author was found!")
        else:
            while found > 0:
                for index in self._books:
                    if self._books[index].author == author:
                        found_books.append(self._books[index])
                        del self._books[index]
                        found -= 1
                        break
        return found_books

    def update_title(self, title, new_title):
        '''
        updates title of a book with new title
        :param title: the old title - str
        :param new_title: the new title - str
        :return:
        '''
        title_exists = 0
        for index in self._books:
            if self._books[index].title == title:
                self._books[index].title = new_title
                title_exists = 1
        if title_exists == 0:
            raise bookRepoError('No book with given title!')

    def update_author(self, author, new_author):
        '''
        updates author of a book with new author
        :param author: the old author
        :param new_author: the new author
        :return:
        '''
        author_exists = 0
        for index in self._books:
            if self._books[index].author == author:
                self._books[index].author = new_author
                author_exists = 1
        if author_exists == 0:
            raise bookRepoError("No book with given author!")

    def search_id(self, book_id):
        book_id = book_id.strip()
        if self.is_integer(book_id) is False:
            raise bookRepoError("ID must be an integer!")
        if int(book_id) <=0:
            raise bookRepoError("ID cannot be a negative number!")
        return list(filter(lambda book: str(book_id) in str(book.book_id), self.books.values()))

    def search_title(self, title):
        if title == '':
            raise bookRepoError("Title cannot be empty string!")
        return list(filter(lambda book: title.strip().lower() in book.title.lower(), self.books.values()))

    def search_author(self, author):
        if author == '':
            raise bookRepoError("Author cannot be empty string!")
        return list(filter(lambda book: author.strip().lower() in book.author.lower(), self.books.values()))

    def test_init(self):
        '''
        creates an initial list of books in a procedural way
        every book appears only once
        :return:
        '''
        book_pairs = ['Don Quixote=Miguel de Cervantes', 'The Great Gatsby=F. Scott Fitzgerald', 'War and Peace=Leo Tolstoy',
                      'Hamlet=William Shakespeare', 'The Catcher in the Rye=J. D. Salinger', 'The Odyssey=Homer',
                      'The Divine Comedy=Dante Alighieri', 'The Adventures of Huckleberry Finn=Mark Twain',
                      'Pride and Prejudice=Jane Austen', 'Anna Karenina=Leo Tolstoy']
        for index in range(10):
            book = choice(book_pairs)
            book_pairs.remove(book)
            book = book.split('=')
            self._books[index+1] = Book(index+1, book[0], book[1])

        return self._books


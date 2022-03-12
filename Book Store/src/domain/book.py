class bookException(Exception):
    '''
    prints an exception related to the book class
    '''
    def __init__(self, msg):
        self._msg = msg


class Book:

    def __init__(self, book_id, title, author):
        '''
        defines a book
        :param book_id: the id of the book - unique! - int
        :param title: title of the book - str
        :param author: author of the book - str
        '''

        self._book_id = book_id
        self._title = title
        self._author = author

    @property
    def book_id(self):
        '''
        gets the id
        :return: the id of the book - int
        '''
        return self._book_id

    @property
    def title(self):
        '''
        gets the title
        :return: the title of the book - str
        '''
        return self._title

    @property
    def author(self):
        '''
        gets the author
        :return: the author of the book - str
        '''
        return self._author

    @title.setter
    def title(self, new_title):
        '''
        sets new title for the book
        :param new_title: the new title of the book - str
        :return:
        '''
        self._title = new_title

    @author.setter
    def author(self, new_author):
        '''
        sets new author for the book
        :param new_author: the new author of the book - str
        :return:
        '''
        self._author = new_author


    def __str__(self):
        '''
        transforms book data to str
        :return: data in str
        '''
        return str(self._book_id).rjust(4) + ' | ' + self._title.ljust(35) + ' | ' + self._author.ljust(20)


class BookValidator:
    def validate(self, book):
        '''
        validates book data
        :param book: entity from book class
        :return:
        '''
        if isinstance(book.book_id, int) is False:
            raise bookException('ID must be an integer!')

        if book.book_id <= 0:
            raise bookException('ID cannot be a negative number!')

        if len(book.title) == 0:
            raise bookException("Title cannot be empty!")

        if len(book.author) == 0:
            raise bookException("Author cannot be empty!")





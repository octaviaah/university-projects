from src.domain.book import Book, BookValidator


class bookServiceError(Exception):
    '''
    prints an exception related to the book service class
    '''
    def __init__(self, msg):
        self._msg = msg


class BookService:
    def __init__(self, repo):
        '''
        gets the book repo
        :param repo: the book repo(or any other book repo) - list of books + functions related to it
        '''
        self._repo = repo

    @property
    def repo(self):
        '''
        return the repo
        :return: the repo - list of books + functions related to it
        '''
        return self._repo

    def create_book(self, book_id, title, author):
        '''
        adds book to the repo
        :param book_id: the id of the book - unique + int
        :param title: title of the book - str
        :param author: author of the book - str
        :return:
        '''
        if self._repo.find_by_id(book_id) == 1:
            raise bookServiceError("Duplicate ID!")
        new_book = Book(book_id, title, author)
        bv = BookValidator()
        bv.validate(new_book)
        self._repo.add(new_book)

    def remove_book(self, book_id, author):
        '''
        removes book by book id or author(ONLY ONE POSSIBLE AT A TIME!)
        :param book_id: the id of the book(in general - int; empty string if user wants to remove by author)
        :param author: the author of the book(str; empty string if user wants to remove by book_id)
        :return:
        '''
        if book_id != '' and author != '':
            raise bookServiceError("You can remove using only one value!")
        if author == '':
            if book_id == '':
                raise bookServiceError('A value must not be None!')
            if self._repo.find_by_id(book_id) == 0:
                raise bookServiceError('This book does not exist!')
            book = self._repo.remove_id(book_id)
            return book
        elif book_id == '':
            found_books = self._repo.remove_author(author)
            return found_books

    def update_book(self, title, new_title, author, new_author):
        '''
        updates title or author of a book(ONLY ONE UPDATE AT A TIME!))
        :param title: the old title of the book(str; empty string if user wants to update author) -
        NEW TITLE MUST NOT BE EMPTY STRING IF TITLE IS NOT EMPTY STRING + vice versa
        :param new_title: the new title of the book(str; empty string if user wants to update author)
        :param author: the old author of the book(str; empty string if user wants to update title) - NEW AUTHOR MUST NOT
        BE EMPTY STRING IF AUTHOR IS NOT EMPTY STRING + vice versa
        :param new_author: the new author of the book(str; empty string if user wants to update title)
        :return:
        '''
        if title != '':
            if new_title == '':
                raise bookServiceError("Title and new_title must have a value each!")
            if author == '' and new_author == '':
                self._repo.update_title(title, new_title)
            else:
                raise bookServiceError("You can't update two different things at the same time!")
        elif new_title != '':
            if author != '' or new_author != '':
                raise bookServiceError("You can't update two different things at the same time!")
            else:
                raise bookServiceError("Title and new_title must have a value each!")
        elif author != '':
            if new_author == '':
                raise bookServiceError("Author and new_author must have a value each!")
            self._repo.update_author(author, new_author)
        else:
            raise bookServiceError("You need to have 2 non-empty string values!")

    def search_book(self, book_id, title, author):
        if book_id == '':
            if title == '':
                return self._repo.search_author(author)
            elif author == '':
                return self._repo.search_title(title)
            else:
                raise bookServiceError("You cannot search by 2 things at the same time!")
        elif title != '' or author != '':
            raise bookServiceError("You cannot search by 2 things at the same time!")
        else:
            return self._repo.search_id(book_id)







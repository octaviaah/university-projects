import pickle

from src.repository.in_memory.book_repo import BookRepository


class BookPickleRepository():
    def __init__(self, file_name):
        super().__init__()
        self.__file_name = file_name
        self.__repo = BookRepository()

    @property
    def books(self):
        return self.__repo.books

    def write_binary_file(self):
        f = open(self.__file_name, "wb")
        pickle.dump(self.__repo.books, f)
        f.close()

    def read_binary_file(self):
        try:
            f = open(self.__file_name, "rb")
            try:
                return pickle.load(f)
            except EOFError:
                return []
            finally:
                f.close()
        except IOError as e:
            print('An error has occurred - ' + str(e))
            raise e

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
        self.read_binary_file()
        book = self.__repo.find(other_id)
        return book

    def find_by_id(self, other_id):
        self.read_binary_file()
        result = self.__repo.find_by_id(other_id)
        return result

    def add(self, book):
        self.read_binary_file()
        self.__repo.add(book)
        self.write_binary_file()

    def remove_id(self, book_id):
        self.read_binary_file()
        book = self.__repo.remove_id(book_id)
        self.write_binary_file()
        return book

    def remove_author(self, author):
        self.read_binary_file()
        found_books = self.__repo.remove_author(author)
        self.write_binary_file()
        return found_books

    def update_title(self, title, new_title):
        self.read_binary_file()
        self.__repo.update_title(title, new_title)
        self.write_binary_file()

    def update_author(self, author, new_author):
        self.read_binary_file()
        self.__repo.update_author(author, new_author)
        self.write_binary_file()

    def search_id(self, book_id):
        self.read_binary_file()
        return self.__repo.search_id(book_id)

    def search_title(self, title):
        self.read_binary_file()
        return self.__repo.search_title(title)

    def search_author(self, author):
        self.read_binary_file()
        return self.__repo.search_author(author)

    def test_init(self):
        if self.read_binary_file() == []:
            self.__repo.test_init()
            self.write_binary_file()
        self.__repo.add_all(self.read_binary_file())
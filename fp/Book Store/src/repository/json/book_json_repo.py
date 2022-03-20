import json

from src.data_structure.data_structure import DataStructure
from src.domain.book import Book
from src.repository.in_memory.book_repo import BookRepository


class BookJSONRepository():
    def __init__(self, file_name):
        super().__init__()
        self.__file_name = file_name
        self.__repo = BookRepository()

    @property
    def books(self):
        return self.__repo.books

    def write_json_file(self):
        f = open(self.__file_name, "wb")
        f.write(json.dumps([x.__dict__ for x in self.__repo.books.values()], indent=4,).encode())
        f.close()

    def read_json_file(self):
        file_data = DataStructure()
        try:
            f = open(self.__file_name, "rb")
            try:
                data = json.loads(f.read().decode())
                for line in data:
                    file_data[line['_book_id']] = Book(line['_book_id'], line['_title'], line['_author'])
            except ValueError:
                return {}
            finally:
                f.close()
        except IOError as e:
            print("An error has occurred - " + str(e))
            raise e
        return file_data

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
        self.read_json_file()
        book = self.__repo.find(other_id)
        return book

    def find_by_id(self, other_id):
        self.read_json_file()
        result = self.__repo.find_by_id(other_id)
        return result

    def add(self, book):
        self.read_json_file()
        self.__repo.add(book)
        self.write_json_file()

    def remove_id(self, book_id):
        self.read_json_file()
        book = self.__repo.remove_id(book_id)
        self.write_json_file()
        return book

    def remove_author(self, author):
        self.read_json_file()
        found_books = self.__repo.remove_author(author)
        self.write_json_file()
        return found_books

    def update_title(self, title, new_title):
        self.read_json_file()
        self.__repo.update_title(title, new_title)
        self.write_json_file()

    def update_author(self, author, new_author):
        self.read_json_file()
        self.__repo.update_author(author, new_author)
        self.write_json_file()

    def search_id(self, book_id):
        self.read_json_file()
        return self.__repo.search_id(book_id)

    def search_title(self, title):
        self.read_json_file()
        return self.__repo.search_title(title)

    def search_author(self, author):
        self.read_json_file()
        return self.__repo.search_author(author)

    def test_init(self):
        if self.read_json_file() == {}:
            self.__repo.test_init()
            self.write_json_file()
        self.__repo.add_all(self.read_json_file())
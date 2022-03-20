from src.repository.json.book_json_repo import BookJSONRepository
from src.repository.json.client_json_repo import ClientJSONRepository
from src.repository.json.rental_json_repo import RentalJSONRepository
from src.repository.pickle.book_pickle_repo import BookPickleRepository
from src.repository.in_memory.book_repo import BookRepository
from src.repository.text.book_text_repo import BookTextRepository
from src.repository.pickle.client_pickle_repo import ClientPickleRepository
from src.repository.in_memory.client_repo import ClientRepository
from src.repository.text.client_text_repo import ClientTextRepository
from src.repository.pickle.rental_pickle_repo import RentalPickleRepository
from src.repository.in_memory.rental_repo import RentalRepository
from src.repository.text.rental_text_repo import RentalTextRepository
from src.ui.console import ui
from src.ui.gui import gui

config_init = {
    'user': 'root',
    'password': '',
    'host': 'localhost',
    'database': 'a9-octaviaah',
    'port': '3306',
    'raise_on_warnings': True,
    'use_pure': False,
}


class Settings:
    def __init__(self, config):
        self.__config = config
        self.__settings = {}

    def read_settings(self):
        print(self.__config)
        f = open(self.__config, "r")
        lines = f.read().split("\n")
        settings = {}
        for line in lines:
            setting = line.split("=")
            if len(setting) > 1:
                self.__settings[setting[0].strip()] = setting[1].strip()

        return self.__settings

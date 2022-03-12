from src.configuration.settings import Settings
from src.repository.in_memory.book_repo import BookRepository
from src.repository.in_memory.client_repo import ClientRepository
from src.repository.in_memory.rental_repo import RentalRepository
from src.repository.json.book_json_repo import BookJSONRepository
from src.repository.json.client_json_repo import ClientJSONRepository
from src.repository.json.rental_json_repo import RentalJSONRepository
from src.repository.pickle.book_pickle_repo import BookPickleRepository
from src.repository.pickle.client_pickle_repo import ClientPickleRepository
from src.repository.pickle.rental_pickle_repo import RentalPickleRepository
from src.repository.text.book_text_repo import BookTextRepository
from src.repository.text.client_text_repo import ClientTextRepository
from src.repository.text.rental_text_repo import RentalTextRepository
from src.ui.console import ui
from src.ui.gui import gui


def start():

    settings = Settings("D:/facultate/fp/a10-octaviaah/settings.properties")
    data = settings.read_settings()

    client_repo = None
    book_repo = None
    rental_repo = None

    if data['repository'] == 'text-file':
        client_repo = ClientTextRepository(data["clients"])
        book_repo = BookTextRepository(data["books"])
        rental_repo = RentalTextRepository(data["rentals"])

    if data['repository'] == "in-memory":
        client_repo = ClientRepository()
        book_repo = BookRepository()
        rental_repo = RentalRepository()

    if data['repository'] == "binary":
        client_repo = ClientPickleRepository(data["clients"])
        book_repo = BookPickleRepository(data["books"])
        rental_repo = RentalPickleRepository(data["rentals"])

    if data['repository'] == "json":
        client_repo = ClientJSONRepository(data["clients"])
        book_repo = BookJSONRepository(data["books"])
        rental_repo = RentalJSONRepository(data["rentals"])

    if data['ui'] == "console":
        console = ui(client_repo, book_repo, rental_repo)
        console.start()

    if data['ui'] == "gui":
        app = gui()
        app.start(client_repo, book_repo, rental_repo)


start()


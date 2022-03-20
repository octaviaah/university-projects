from datetime import date
from tkinter import *
from tkinter import messagebox

from src.domain.book import bookException
from src.domain.client import clientException
from src.domain.rental import rentalException
from src.repository.in_memory.book_repo import bookRepoError
from src.repository.in_memory.client_repo import clientRepoError
from src.repository.in_memory.rental_repo import rentalRepoError, RentalRepository
from src.service.book_service import BookService, bookServiceError
from src.service.client_service import ClientService, clientServiceError
from src.service.rental_service import RentalService, rentalServiceError
from src.service.undo_service import UndoService, Operation, FunctionCall, Cascade, undoServiceError


class gui:
    def __init__(self):
        self.tk = Tk()

    def start(self, cr, br, rr):
        frame = self.tk
        frame.title('LIBRARY')

        self._client_repo = cr
        self._client_serv = ClientService(self._client_repo)
        self._book_repo = br
        self._book_serv = BookService(self._book_repo)
        self._rental_repo = rr
        self._rental_serv = RentalService(self._rental_repo)
        self._undo_serv = UndoService()
        self._client_serv.repo.test_init()
        self._book_serv.repo.test_init()

        lbl = Label(frame, text='Welcome to the Library!\n', font='{Lucida Handwriting} 14')
        lbl.grid(row=1, column=3)

        lbl = Label(frame, text="CLIENT commands\n", font='Calibri 12 bold')
        lbl.grid(row=2, column=1, ipadx=10, ipady=10)
        lbl = Label(frame, text="BOOK commands\n", font='Calibri 12 bold')
        lbl.grid(row=2, column=2, ipadx=10, ipady=10)
        lbl = Label(frame, text="RENTAL commands\n", font='Calibri 12 bold')
        lbl.grid(row=2, column=3, ipadx=10, ipady=10)
        lbl = Label(frame, text="STATISTICS commands\n", font='Calibri 12 bold')
        lbl.grid(row=2, column=4, ipadx=10, ipady=10)
        lbl = Label(frame, text="UNDO\REDO\n", font='Calibri 12 bold')
        lbl.grid(row=2, column=5, ipadx=10, ipady=10)

        self.button = Button(frame, text="Add client", command=self._read_client_for_add, bg='#e9f0a3', font='{Comic Sans MS} 10')
        self.button.grid(row=3, column=1, ipadx=2, ipady=2)
        self.button = Button(frame, text="Add book", command=self._read_book_for_add, bg='#e9f0a3', font='{Comic Sans MS} 10')
        self.button.grid(row=3, column=2, ipadx=2, ipady=2)

        lbl = Label(frame, text="\n")
        lbl.grid(row=4, column=1)
        lbl = Label(frame, text="\n")
        lbl.grid(row=4, column=2)
        lbl = Label(frame, text="\n")
        lbl.grid(row=4, column=3)

        self.button = Button(frame, text="Remove client", command=self._read_client_for_remove, bg='#aafafa',
                             font='{Comic Sans MS} 10')
        self.button.grid(row=5, column=1, ipadx=2, ipady=2)
        self.button = Button(frame, text="Remove book", command=self._read_book_for_remove, bg='#aafafa', font='{Comic Sans MS} 10')
        self.button.grid(row=5, column=2, ipadx=2, ipady=2)
        self.button = Button(frame, text="Rent a book", command=self._rent_a_book, bg='#e6a39e', font='{Comic Sans MS} 10')
        self.button.grid(row=5, column=3, ipadx=2, ipady=2)
        self.button = Button(frame, text="Most rented books", command=self._list_most_rented_books, bg='#97b6de',
                             font='{Comic Sans MS} 10')
        self.button.grid(row=5, column=4, ipadx=2, ipady=2)
        self.button = Button(frame, text="Undo action", command=self._undo_action, bg='#caccc2', font='{Comic Sans '
                                                                                                      'MS} 10')
        self.button.grid(row=5, column=5, ipadx=2, ipady=2)

        lbl = Label(frame, text="\n")
        lbl.grid(row=6, column=1)
        lbl = Label(frame, text="\n")
        lbl.grid(row=6, column=2)
        lbl = Label(frame, text="\n")
        lbl.grid(row=6, column=3)
        lbl = Label(frame, text="\n")
        lbl.grid(row=6, column=4)
        lbl = Label(frame, text="\n")
        lbl.grid(row=6, column=5)

        self.button = Button(frame, text="Update client", command=self._read_client_for_update, bg='#f7b5e9', font='{Comic Sans MS} 10')
        self.button.grid(row=7, column=1, ipadx=2, ipady=2)
        self.button = Button(frame, text="Update book", command=self._read_book_for_update, bg='#f7b5e9', font='{Comic Sans MS} 10')
        self.button.grid(row=7, column=2, ipadx=2, ipady=2)
        self.button = Button(frame, text="Return a book", command=self._return_a_book, bg='#7ac2a6', font='{Comic Sans MS} 10')
        self.button.grid(row=7, column=3, ipadx=2, ipady=2)
        self.button = Button(frame, text="Most active clients", command=self._list_most_active_clients, bg='#97b6de', font='{Comic Sans MS} 10')
        self.button.grid(row=7, column=4, ipadx=2, ipady=2)

        lbl = Label(frame, text="\n")
        lbl.grid(row=8, column=1)
        lbl = Label(frame, text="\n")
        lbl.grid(row=8, column=2)
        lbl = Label(frame, text="\n")
        lbl.grid(row=8, column=3)
        lbl = Label(frame, text="\n")
        lbl.grid(row=8, column=4)

        self.button = Button(frame, text="List clients", command=self._list_clients, bg='#bcf7b7', font='{Comic Sans MS} 10')
        self.button.grid(row=9, column=1, ipadx=2, ipady=2)
        self.button = Button(frame, text="List books", command=self._list_books, bg='#bcf7b7', font='{Comic Sans MS} 10')
        self.button.grid(row=9, column=2, ipadx=2, ipady=2)
        self.button = Button(frame, text="List rentals", command=self._list_rentals, bg='#bcf7b7', font='{Comic Sans MS} 10')
        self.button.grid(row=9, column=3, ipadx=2, ipady=2)
        self.button = Button(frame, text="Books authored for \nmost rented author",
                             command=self._list_most_rented_author, bg='#daa2eb', font='{Comic Sans MS} 10')
        self.button.grid(row=9, column=4, ipadx=2, ipady=2)
        self.button = Button(frame, text="Redo action", command=self._redo_action, bg='#caccc2', font='{Comic Sans '
                                                                                                      'MS} 10')
        self.button.grid(row=9, column=5, ipadx=2, ipady=2)

        lbl = Label(frame, text="\n")
        lbl.grid(row=10, column=1)
        lbl = Label(frame, text="\n")
        lbl.grid(row=10, column=2)
        lbl = Label(frame, text="\n")
        lbl.grid(row=10, column=3)
        lbl = Label(frame, text="\n")
        lbl.grid(row=10, column=5)

        self.button = Button(frame, text="Search for client", command=self._read_client_for_search, bg='#ebcdae', font='{Comic Sans MS} 10')
        self.button.grid(row=11, column=1, ipadx=2, ipady=2)
        self.button = Button(frame, text="Search for book", command=self._read_book_for_search, bg='#ebcdae', font='{Comic Sans MS} 10')
        self.button.grid(row=11, column=2, ipadx=2, ipady=2)

        lbl = Label(frame, text="\n")
        lbl.grid(row=12, column=1)
        lbl = Label(frame, text="\n")
        lbl.grid(row=12, column=2)

        self.button = Button(frame, text="QUIT", font= 'Helvetica 22 bold italic', bg="red", command=frame.quit)
        self.button.grid(row=13, column=3, ipadx=10, ipady=10)

        lbl = Label(frame, text="\n")
        lbl.grid(row=14, column=2)

        self.tk.mainloop()

    def _read_client_for_add(self):
        window = Toplevel(self.tk)
        window.title("ADD CLIENT")

        lbl = Label(window, text="Enter client credentials\n", font='Calibri 12 bold')
        lbl.grid(row=1, column=1)

        lbl = Label(window, text="Client ID: ")
        lbl.grid(row=2, column=1)
        lbl = Label(window, text="Name: ")
        lbl.grid(row=4, column=1)

        lbl = Label(window, text="\n")
        lbl.grid(row=3, column=1)
        lbl = Label(window, text="\n")
        lbl.grid(row=5, column=1)
        lbl = Label(window, text='\n')
        lbl.grid(row=7, column=1)

        self.client_id = Entry(window , {})
        self.client_id.grid(row=2, column=2, padx=20)
        self.name = Entry(window, {})
        self.name.grid(row=4, column=2)

        self.button = Button(window, text="Add client to database", command=self._add_client)
        self.button.grid(row=6, column=1, columnspan=2)

    def _add_client(self):
        try:
            if self._client_serv.repo.is_integer(self.client_id.get()) is False:
                raise clientServiceError("ID must have an integer value!")
            if int(self.client_id.get()) <= 0:
                raise clientServiceError("Client ID cannot be a negative number!")
            if self._client_serv.repo.find_by_id(int(self.client_id.get())) == 1:
                raise clientServiceError("Duplicate ID!")

            self._client_serv.create_client(int(self.client_id.get()), self.name.get())

            undo = FunctionCall(self._client_serv.remove_client, int(self.client_id.get()))
            redo = FunctionCall(self._client_serv.create_client, int(self.client_id.get()), self.name.get())
            operation = Operation(undo, redo)
            self._undo_serv.record(operation)

            messagebox.showinfo("Succes!", "Client was added to the database!")
        except (clientServiceError, clientException) as e:
            messagebox.showinfo("Error", str(e))

    def _read_client_for_remove(self):
        window = Toplevel(self.tk)
        window.title("REMOVE CLIENT")

        lbl = Label(window, text="Enter client credentials\n", font='Calibri 12 bold')
        lbl.grid(row=1, column=1)

        lbl = Label(window, text="Client ID: ")
        lbl.grid(row=2, column=1)

        lbl = Label(window, text="\n")
        lbl.grid(row=3, column=1)
        lbl = Label(window, text="\n")
        lbl.grid(row=5, column=1)

        self.client_id = Entry(window, {})
        self.client_id.grid(row=2, column=2, padx=20)

        self.button = Button(window, text="Remove client from database", command=self._remove_client)
        self.button.grid(row=4, column=1, columnspan=2)

    def _remove_client(self):
        try:
            if self._client_serv.repo.is_integer(self.client_id.get()) is False:
                raise clientServiceError("ID must have an integer value!")
            if int(self.client_id.get()) <= 0:
                raise clientServiceError("Client ID cannot be a negative number!")

            client = self._client_serv.remove_client(int(self.client_id.get()))
            found_rentals = self._rental_repo.remove_rental_client(int(self.client_id.get()))

            undo = FunctionCall(self._client_serv.create_client, int(client.client_id), client.name)
            redo = FunctionCall(self._client_serv.remove_client, int(client.client_id))
            operation = Operation(undo, redo)
            cascade_list = [operation]
            for rental in found_rentals:
                undo = FunctionCall(self._rental_serv.create_rental, rental.rental_id, rental.client_id, rental.book_id,
                                    rental.rented_date, rental.returned_date)
                redo = FunctionCall(self._rental_repo.remove_rental_id, rental.rental_id)
                cascade_list.append(Operation(undo, redo))

            cop = Cascade(*cascade_list)
            self._undo_serv.record(cop)

            messagebox.showinfo("Succes!", "Client was removed from the database!")
        except (clientServiceError, clientException) as e:
            messagebox.showinfo("Error", str(e))

    def _read_client_for_update(self):
        window = Toplevel(self.tk)
        window.title("UPDATE CLIENT")

        lbl = Label(window, text="Enter client credentials\n", font='Calibri 12 bold')
        lbl.grid(row=1, column=1)

        lbl = Label(window, text="Name: ")
        lbl.grid(row=2, column=1)
        lbl = Label(window, text="New name: ")
        lbl.grid(row=4, column=1)

        lbl = Label(window, text="\n")
        lbl.grid(row=3, column=1)
        lbl = Label(window, text="\n")
        lbl.grid(row=5, column=1)
        lbl = Label(window, text="\n")
        lbl.grid(row=7, column=1)

        self.name = Entry(window, {})
        self.name.grid(row=2, column=2, padx=20)
        self.new_name = Entry(window, {})
        self.new_name.grid(row=4, column=2)

        self.button = Button(window, text="Update client from database", command=self._update_client)
        self.button.grid(row=6, column=1, columnspan=2)

    def _update_client(self):
        try:
            self._client_serv.update_client(self.name.get(), self.new_name.get())

            undo = FunctionCall(self._client_serv.update_client, self.new_name.get(), self.name.get())
            redo = FunctionCall(self._client_serv.update_client, self.name.get(), self.new_name.get())
            operation = Operation(undo, redo)
            self._undo_serv.record(operation)

            messagebox.showinfo("Succes!", "Client was updated!")
        except (clientServiceError, clientRepoError, clientException) as e:
            messagebox.showinfo("Error", str(e))

    def _read_client_for_search(self):
        window = Toplevel(self.tk)
        window.title("SEARCH CLIENT")

        lbl = Label(window, text="Enter client credentials\n", font='Calibri 12 bold')
        lbl.grid(row=1, column=1)

        lbl = Label(window, text="Client ID: ")
        lbl.grid(row=2, column=1)
        lbl = Label(window, text="Name: ")
        lbl.grid(row=4, column=1)

        lbl = Label(window, text="\n")
        lbl.grid(row=3, column=1)
        lbl = Label(window, text="\n")
        lbl.grid(row=5, column=1)
        lbl = Label(window, text="\n")
        lbl.grid(row=7, column=1)

        self.client_id = Entry(window, {})
        self.client_id.grid(row=2, column=2, padx=20)
        self.name = Entry(window, {})
        self.name.grid(row=4, column=2)

        self.button = Button(window, text="Search client from database", command=self._search_client)
        self.button.grid(row=6, column=1, columnspan=2)

    def _search_client(self):
        try:
            sorted_list = self._client_serv.search_client(self. client_id.get(), self.name.get())
            if len(sorted_list) == 0:
                messagebox.showinfo('Error', 'No client was found!')
            else:
                new_window = Toplevel(self.tk)
                new_window.title("SEARCH RESULTS")

                txt_id = "ID\n"
                txt_name = 'Name\n'

                for element in sorted_list:
                    txt_id += str(element.client_id)
                    txt_name += element.name
                    txt_id += '\n'
                    txt_name += '\n'

                lbl = Label(new_window, text=txt_id)
                lbl.grid(row=3, column=1)
                lbl = Label(new_window, text=txt_name)
                lbl.grid(row=3, column=2)
        except (clientServiceError, clientRepoError) as e:
            messagebox.showinfo("Error", str(e))

    def _list_clients(self):
        window = Toplevel(self.tk)
        window.title("LIST CLIENTS")

        txt_id = "ID\n"
        txt_name = "Name\n"
        for client in self._client_repo.clients.values():
            txt_id += str(client.client_id)
            txt_id += '\n'
            txt_name += client.name
            txt_name += '\n'

        lbl = Label(window, text=txt_id)
        lbl.grid(row=3, column=1)
        lbl = Label(window, text=txt_name)
        lbl.grid(row=3, column=2)

    def _read_book_for_add(self):
        window = Toplevel(self.tk)
        window.title("ADD BOOK")

        lbl = Label(window, text="Enter book credentials\n", font='Calibri 12 bold')
        lbl.grid(row=1, column=1)

        lbl = Label(window, text="Book ID: ")
        lbl.grid(row=2, column=1)
        lbl = Label(window, text="Title: ")
        lbl.grid(row=4, column=1)
        lbl = Label(window, text="Author: ")
        lbl.grid(row=6, column=1)

        lbl = Label(window, text="\n")
        lbl.grid(row=3, column=1)
        lbl = Label(window, text="\n")
        lbl.grid(row=5, column=1)
        lbl = Label(window, text='\n')
        lbl.grid(row=7, column=1)
        lbl = Label(window, text='\n')
        lbl.grid(row=9, column=1)

        self.book_id = Entry(window, {})
        self.book_id.grid(row=2, column=2, padx=20)
        self.title = Entry(window, {})
        self.title.grid(row=4, column=2)
        self.author = Entry(window, {})
        self.author.grid(row=6, column=2)

        self.button = Button(window, text="Add book to database", command=self._add_book)
        self.button.grid(row=8, column=1, columnspan=2)

    def _add_book(self):
        try:
            if self._book_serv.repo.is_integer(self.book_id.get()) is False:
                raise bookServiceError("ID must be an integer value!")
            if int(self.book_id.get()) <= 0:
                raise bookServiceError("Book ID cannot be a negative number!")
            if self._book_serv.repo.find_by_id(int(self.book_id.get())) == 1:
                raise bookServiceError("Duplicate ID!")
            self._book_serv.create_book(int(self.book_id.get()), self.title.get(), self.author.get())

            undo = FunctionCall(self._book_serv.repo.remove_id, int(self.book_id.get()))
            redo = FunctionCall(self._book_serv.create_book, int(self.book_id.get()), self.title.get(),
                                self.author.get())
            operation = Operation(undo, redo)
            self._undo_serv.record(operation)

            messagebox.showinfo("Succes!", "Book was added to the database!")
        except (bookServiceError, bookException) as e:
            messagebox.showinfo("Error", str(e))

    def _read_book_for_remove(self):
        window = Toplevel(self.tk)
        window.title("ADD BOOK")

        lbl = Label(window, text="Enter book credentials\n", font='Calibri 12 bold')
        lbl.grid(row=1, column=1)

        lbl = Label(window, text="Book ID: ")
        lbl.grid(row=2, column=1)
        lbl = Label(window, text="Author: ")
        lbl.grid(row=4, column=1)

        lbl = Label(window, text="\n")
        lbl.grid(row=3, column=1)
        lbl = Label(window, text="\n")
        lbl.grid(row=5, column=1)
        lbl = Label(window, text='\n')
        lbl.grid(row=7, column=1)

        self.book_id = Entry(window, {})
        self.book_id.grid(row=2, column=2, padx=20)
        self.author = Entry(window, {})
        self.author.grid(row=4, column=2)

        self.button = Button(window, text="Remove book from database", command=self._remove_book)
        self.button.grid(row=6, column=1, columnspan=2)

    def _remove_book(self):
        try:
            if self.book_id.get() != '':
                if self._book_serv.repo.is_integer(self.book_id.get()) is False:
                    raise bookServiceError("ID must be an integer value!")
                if int(self.book_id.get()) <= 0:
                    raise bookServiceError("Book ID cannot be a negative number!")
            if self.book_id.get() == '':
                found_books = self._book_serv.remove_book('', self.author.get())

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

                messagebox.showinfo("Succes!", "Book was removed from the database!")
            else:
                book = self._book_serv.remove_book(int(self.book_id.get()), self.author.get())
                found_rentals = self._rental_repo.remove_rental_book(int(self.book_id.get()))

                undo = FunctionCall(self._book_serv.create_book, int(book.book_id), book.title, book.author)
                redo = FunctionCall(self._book_serv.repo.remove_id, int(book.book_id))
                cascade_list = [Operation(undo, redo)]
                for rental in found_rentals:
                    undo = FunctionCall(self._rental_serv.create_rental, rental.rental_id, rental.client_id,
                                        rental.book_id, rental.rented_date, rental.returned_date)
                    redo = FunctionCall(self._rental_repo.remove_rental_book, rental.book_id)
                    cascade_list.append(Operation(undo, redo))

                messagebox.showinfo("Succes!", "Book was removed from the database!")

            cop = Cascade(*cascade_list)
            self._undo_serv.record(cop)
        except (bookServiceError, bookException) as e:
            messagebox.showinfo("Error", str(e))

    def _read_book_for_update(self):
        window = Toplevel(self.tk)
        window.title("UPDATE BOOK")

        lbl = Label(window, text="Enter book credentials\n", font='Calibri 12 bold')
        lbl.grid(row=1, column=1)

        lbl = Label(window, text="Title: ")
        lbl.grid(row=2, column=1)
        lbl = Label(window, text="New title: ")
        lbl.grid(row=4, column=1)
        lbl = Label(window, text="Author: ")
        lbl.grid(row=6, column=1)
        lbl = Label(window, text="New author: ")
        lbl.grid(row=8, column=1)

        lbl = Label(window, text="\n")
        lbl.grid(row=3, column=1)
        lbl = Label(window, text="\n")
        lbl.grid(row=5, column=1)
        lbl = Label(window, text="\n")
        lbl.grid(row=7, column=1)
        lbl = Label(window, text="\n")
        lbl.grid(row=9, column=1)
        lbl = Label(window, text="\n")
        lbl.grid(row=11, column=1)

        self.title = Entry(window, {})
        self.title.grid(row=2, column=2, padx=20)
        self.new_title = Entry(window, {})
        self.new_title.grid(row=4, column=2)
        self.author = Entry(window, {})
        self.author.grid(row=6, column=2)
        self.new_author = Entry(window, {})
        self.new_author.grid(row=8, column=2)

        self.button = Button(window, text="Update book from database", command=self._update_book)
        self.button.grid(row=10, column=1, columnspan=2)

    def _update_book(self):
        try:
            self._book_serv.update_book(self.title.get(), self.new_title.get(), self.author.get(),
                                        self.new_author.get())

            if self.title.get() == '' and self.new_title.get() == '':
                undo = FunctionCall(self._book_serv.repo.update_author, self.new_author.get(), self.author.get())
                redo = FunctionCall(self._book_serv.repo.update_author, self.author.get(), self.new_author.get())
            else:
                undo = FunctionCall(self._book_serv.repo.update_title, self.new_title.get(), self.title.get())
                redo = FunctionCall(self._book_serv.repo.update_title, self.title.get(), self.new_title.get())

            operation = Operation(undo, redo)
            self._undo_serv.record(operation)

            messagebox.showinfo("Succes!", "Book was updated!")
        except (bookServiceError, bookRepoError, bookException) as e:
            messagebox.showinfo("Error", str(e))

    def _read_book_for_search(self):
        window = Toplevel(self.tk)
        window.title("SEARCH BOOK")

        lbl = Label(window, text="Enter book credentials\n", font='Calibri 12 bold')
        lbl.grid(row=1, column=1)

        lbl = Label(window, text="Book ID: ")
        lbl.grid(row=2, column=1)
        lbl = Label(window, text="Title: ")
        lbl.grid(row=4, column=1)
        lbl = Label(window, text="Author: ")
        lbl.grid(row=6, column=1)

        lbl = Label(window, text="\n")
        lbl.grid(row=3, column=1)
        lbl = Label(window, text="\n")
        lbl.grid(row=5, column=1)
        lbl = Label(window, text="\n")
        lbl.grid(row=7, column=1)
        lbl = Label(window, text="\n")
        lbl.grid(row=9, column=1)

        self.book_id = Entry(window, {})
        self.book_id.grid(row=2, column=2, padx=20)
        self.title = Entry(window, {})
        self.title.grid(row=4, column=2)
        self.author = Entry(window, {})
        self.author.grid(row=6, column=2)

        self.button = Button(window, text="Search book from database", command=self._search_book)
        self.button.grid(row=8, column=1, columnspan=2)

    def _search_book(self):
        try:
            sorted_list = self._book_serv.search_book(self.book_id.get(), self.title.get(), self.author.get())
            if len(sorted_list) == 0:
                messagebox.showinfo('Error', 'No book was found!')
            else:
                new_window = Toplevel(self.tk)
                new_window.title("SEARCH RESULTS")

                txt_id = "ID\n"
                txt_title = 'Title\n'
                txt_author = "Author\n"

                for element in sorted_list:
                    txt_id += str(element.book_id)
                    txt_title += element.title
                    txt_author += element.author
                    txt_id += '\n'
                    txt_title += '\n'
                    txt_author += '\n'

                lbl = Label(new_window, text=txt_id)
                lbl.grid(row=3, column=1)
                lbl = Label(new_window, text=txt_title)
                lbl.grid(row=3, column=2)
                lbl = Label(new_window, text=txt_author)
                lbl.grid(row=3, column=3)
        except (bookServiceError, bookRepoError) as e:
            messagebox.showinfo("Error", str(e))

    def _list_books(self):
        window = Toplevel(self.tk)
        window.title("LIST BOOKS")

        txt_id = "ID\n"
        txt_title = "Title\n"
        txt_author = "Author\n"

        for book in self._book_repo.books.values():
            txt_id += str(book.book_id)
            txt_id += '\n'
            txt_title += book.title
            txt_title += '\n'
            txt_author += book.author
            txt_author += '\n'

        lbl = Label(window, text=txt_id)
        lbl.grid(row=3, column=1)
        lbl = Label(window, text=txt_title)
        lbl.grid(row=3, column=2)
        lbl = Label(window, text=txt_author)
        lbl.grid(row=3, column=3)

    def _rent_a_book(self):
        window = Toplevel(self.tk)
        window.title("RENT A BOOK")

        lbl = Label(window, text="Enter rental credentials\n", font='Calibri 12 bold')
        lbl.grid(row=1, column=1)

        lbl = Label(window, text="Client ID: ")
        lbl.grid(row=2, column=1)
        lbl = Label(window, text="Book ID: ")
        lbl.grid(row=4, column=1)
        lbl = Label(window, text="Rental day: ")
        lbl.grid(row=6, column=1)
        lbl = Label(window, text="Rental month(in numbers): ")
        lbl.grid(row=8, column=1)

        lbl = Label(window, text="\n")
        lbl.grid(row=3, column=1)
        lbl = Label(window, text="\n")
        lbl.grid(row=5, column=1)
        lbl = Label(window, text="\n")
        lbl.grid(row=7, column=1)
        lbl = Label(window, text="\n")
        lbl.grid(row=9, column=1)
        lbl = Label(window, text="\n")
        lbl.grid(row=11, column=1)

        self.button = Button(window, text="Rent", command=self._add_rental)
        self.button.grid(row=10, column=1, columnspan=2)

        self.rent_cid = Entry(window, {})
        self.rent_cid.grid(row=2, column=2, padx=20)
        self.rent_bid = Entry(window, {})
        self.rent_bid.grid(row=4, column=2)
        self.day = Entry(window, {})
        self.day.grid(row=6, column=2)
        self.month = Entry(window, {})
        self.month.grid(row=8, column=2)

    def _add_rental(self):
        try:
            length = len(self._rental_repo)
            if self._rental_serv.repo.is_integer(self.rent_cid.get()) is False:
                raise rentalServiceError("ID must be an integer value!")
            if int(self.rent_cid.get()) <= 0:
                raise rentalServiceError("Client ID cannot be a negative number!")
            if self._client_serv.repo.find_by_id(int(self.rent_cid.get())) == 0:
                raise rentalServiceError("Client does not exist!")

            if self._rental_serv.repo.is_integer(self.rent_bid.get()) is False:
                raise rentalServiceError("ID must be an integer value!")
            if int(self.rent_bid.get()) <= 0:
                raise rentalServiceError("Book ID cannot be a negative number!")
            if self._book_serv.repo.find_by_id(int(self.rent_bid.get())) == 0:
                raise rentalServiceError("Book does not exist!")

            if self._rental_serv.repo.is_integer(self.day.get()) is False:
                raise rentalServiceError("Rental day must be an integer!")
            if int(self.day.get()) < 1 or int(self.day.get()) > 31:
                raise rentalServiceError("Rental day must be between 1 and 31!")

            if self._rental_serv.repo.is_integer(self.month.get()) is False:
                raise rentalServiceError("Rental month must be an integer!")
            if int(self.month.get()) < 1 or int(self.month.get()) > 12:
                raise rentalServiceError("Rental month must be between 1 and 12!")

            self._rental_serv.create_rental(length+1, int(self.rent_cid.get()), int(self.rent_bid.get()), date(2020,int(self.month.get()), int(self.day.get())), '')

            undo = FunctionCall(self._rental_serv.repo.remove_rental_id, length + 1)
            redo = FunctionCall(self._rental_serv.create_rental, length + 1, int(self.rent_cid.get()),
                                int(self.rent_bid.get()),
                                date(2020, int(self.month.get()),
                                     int(self.day.get())), '')
            operation = Operation(undo, redo)
            self._undo_serv.record(operation)

            messagebox.showinfo("Success!", "Book was rented!")
        except (rentalServiceError, rentalException) as e:
            messagebox.showinfo("Error", str(e))

    def _return_a_book(self):
        window = Toplevel(self.tk)
        window.title("RETURN A BOOK")

        lbl = Label(window, text="Enter rental credentials\n", font='Calibri 12 bold')
        lbl.grid(row=1, column=1)

        lbl = Label(window, text="Book ID: ")
        lbl.grid(row=2, column=1)

        lbl = Label(window, text="\n")
        lbl.grid(row=3, column=1)
        lbl = Label(window, text="\n")
        lbl.grid(row=5, column=1)

        self.button = Button(window, text="Return", command=self._update_rental)
        self.button.grid(row=4, column=1, columnspan=2)

        self.return_bid = Entry(window, {})
        self.return_bid.grid(row=2, column=2, padx=20)

    def _update_rental(self):
        try:
            if self._rental_serv.repo.is_integer(self.return_bid.get()) is False:
                raise rentalServiceError("ID must be an integer value!")
            if int(self.return_bid.get()) <= 0:
                raise rentalServiceError("Book ID cannot be a negative number!")
            returned_date = date.today()
            self._rental_serv.update_rental(int(self.return_bid.get()), returned_date)

            undo = FunctionCall(self._rental_serv.repo.update_reverse, int(self.return_bid.get()), '')
            redo = FunctionCall(self._rental_serv.update_rental, int(self.return_bid.get()), returned_date)

            operation = Operation(undo, redo)
            self._undo_serv.record(operation)

            messagebox.showinfo("Success!", "Book was returned!")
        except (rentalServiceError, rentalRepoError, rentalException) as e:
            messagebox.showinfo("Error", str(e))


    def _list_rentals(self):
        window = Toplevel(self.tk)
        window.title("LIST RENTALS")

        txt_rid = "Rental ID\n"
        txt_cid = "Client ID\n"
        txt_bid = "Book ID\n"
        txt_rented_date = "Rented date\n"
        txt_returned_date = "Returned date\n"

        for rental in self._rental_repo.rentals.values():
            txt_rid += str(rental.rental_id)
            txt_rid += '\n'
            txt_cid += str(rental.client_id)
            txt_cid += '\n'
            txt_bid += str(rental.book_id)
            txt_bid += '\n'
            txt_rented_date += str(rental.rented_date)
            txt_rented_date += '\n'
            txt_returned_date += str(rental.returned_date)
            txt_returned_date += '\n'

        lbl = Label(window, text=txt_rid)
        lbl.grid(row=3, column=1)
        lbl = Label(window, text=txt_cid)
        lbl.grid(row=3, column=2)
        lbl = Label(window, text=txt_bid)
        lbl.grid(row=3, column=3)
        lbl = Label(window, text=txt_rented_date)
        lbl.grid(row=3, column=4)
        lbl = Label(window, text=txt_returned_date)
        lbl.grid(row=3, column=5)

    def _list_most_rented_books(self):
        window = Toplevel(self.tk)
        window.title("MOST RENTED BOOKS")

        lbl = Label(window, text="The most rented books are:\n")
        lbl.grid(row=1, column=1, columnspan=3)

        top_books = self._rental_serv.most_rented_books(self._book_repo)
        index = 1

        txt_id = "No.\n"
        txt_title = "Title\n"
        txt_times = "Times rented\n"

        for book in top_books:
            txt_id += str(index)
            txt_id += '\n'
            txt_title += book[0]
            txt_title += '\n'
            txt_times += str(book[1])
            txt_times += '\n'
            index += 1

        lbl = Label(window, text=txt_id)
        lbl.grid(row=3, column=1)
        lbl = Label(window, text=txt_title)
        lbl.grid(row=3, column=2)
        lbl = Label(window, text=txt_times)
        lbl.grid(row=3, column=3, padx=20)

    def _list_most_active_clients(self):
        window = Toplevel(self.tk)
        window.title("MOST ACTIVE CLIENTS")

        lbl = Label(window, text="The most active clients are:\n")
        lbl.grid(row=1, column=1, columnspan=3)

        top_clients = self._rental_serv.most_active_clients(self._client_repo)
        index = 1
        txt_id = "No.\n"
        txt_name = "Name\n"
        txt_days = "Days rented\n"

        for client in top_clients:
            txt_id += str(index)
            txt_id += '\n'
            txt_name += client[0]
            txt_name += '\n'
            txt_days += str(client[1])
            txt_days += '\n'
            index += 1

        lbl = Label(window, text=txt_id)
        lbl.grid(row=3, column=1)
        lbl = Label(window, text=txt_name)
        lbl.grid(row=3, column=2)
        lbl = Label(window, text=txt_days)
        lbl.grid(row=3, column=3, padx=20)

    def _list_most_rented_author(self):
        window = Toplevel(self.tk)
        window.title("MOST ACTIVE CLIENTS")

        top_books_authored = self._rental_serv.most_rented_author(self._book_repo)
        lbl = Label(window, text="The most rented author is " + top_books_authored[0][0][2] + " and their books were "
                                                                                              "rented " + str(
            top_books_authored[0][
            0][3]) + " times. The list of books authored by " + top_books_authored[0][0][2] + " are:\n")
        lbl.grid(row=1, column=1, columnspan=3)
        index = 1

        txt_id = 'No.\n'
        txt_title = 'Title\n'
        txt_times = 'Times rented\n'

        for author in top_books_authored:
            for book in author:
                txt_id += str(index)
                txt_id += '\n'
                txt_title += book[0]
                txt_title += '\n'
                txt_times += str(book[1])
                txt_times += '\n'
                index += 1

        lbl = Label(window, text=txt_id)
        lbl.grid(row=3, column=1)
        lbl = Label(window, text=txt_title)
        lbl.grid(row=3, column=2)
        lbl = Label(window, text=txt_times)
        lbl.grid(row=3, column=3, padx=20)

    def _undo_action(self):
        try:
            self._undo_serv.undo()
            messagebox.showinfo('Success!', 'Undo done!')
        except undoServiceError as e:
            messagebox.showinfo('Error', 'No more undos!')

    def _redo_action(self):
        try:
            self._undo_serv.redo()
            messagebox.showinfo('Success!', 'Redo done!')
        except undoServiceError as e:
            messagebox.showinfo('Error', 'No more redos!')

#gui = gui()
#gui.start(ClientRepository(), BookRepository(), RentalRepository())
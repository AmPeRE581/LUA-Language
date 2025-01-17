-- Descrizione dell'Esercizio
-- Crea un programma in Lua che gestisce una biblioteca con le seguenti caratteristiche:

-- Classe Book:

-- Ogni libro ha un titolo, un autore, un anno di pubblicazione e uno stato di disponibilità (disponibile/non disponibile).
-- Classe Library:

-- La biblioteca contiene un elenco di libri.
-- La biblioteca permette di aggiungere nuovi libri.
-- La biblioteca permette di cercare un libro per titolo o autore.
-- La biblioteca permette di prestare un libro (cambiando il suo stato a "non disponibile").
-- La biblioteca permette di restituire un libro (cambiando il suo stato a "disponibile").
-- Interazione con l'utente:

-- Il programma deve fornire un'interfaccia utente semplice per interagire con la biblioteca, permettendo di aggiungere, cercare, prestare e restituire libri.



-- Definizione della classe Book
Book = {}
Book.__index = Book

function Book:new(title, author, year)
    local book = {
        title = title,
        author = author,
        year = year,
        available = true
    }
    setmetatable(book, Book)
    return book
end

function Book:display()
    local status = self.available and "Available" or "Not Available"
    print("Title: " .. self.title .. ", Author: " .. self.author .. ", Year: " .. self.year .. ", Status: " .. status)
end

-- Definizione della classe Library
Library = {}
Library.__index = Library

function Library:new()
    local library = {
        books = {}
    }
    setmetatable(library, Library)
    return library
end

function Library:addBook(book)
    table.insert(self.books, book)
end

function Library:findBookByTitle(title)
    for _, book in ipairs(self.books) do
        if book.title == title then
            return book
        end
    end
    return nil
end

function Library:findBookByAuthor(author)
    for _, book in ipairs(self.books) do
        if book.author == author then
            return book
        end
    end
    return nil
end

function Library:lendBook(title)
    local book = self:findBookByTitle(title)
    if book and book.available then
        book.available = false
        print("Book '" .. title .. "' has been lent out.")
    else
        print("Book '" .. title .. "' is not available.")
    end
end

function Library:returnBook(title)
    local book = self:findBookByTitle(title)
    if book and not book.available then
        book.available = true
        print("Book '" .. title .. "' has been returned.")
    else
        print("Book '" .. title .. "' was not lent out.")
    end
end

function Library:displayBooks()
    for _, book in ipairs(self.books) do
        book:display()
    end
end

-- Creazione della biblioteca e interazione con l'utente
local myLibrary = Library:new()

while true do
    print("\nLibrary Management System")
    print("1. Add Book")
    print("2. Search Book by Title")
    print("3. Search Book by Author")
    print("4. Lend Book")
    print("5. Return Book")
    print("6. Display All Books")
    print("7. Exit")
    io.write("Select an option: ")
    local choice = io.read("*n")

    if choice == 1 then
        io.write("Enter title: ")
        local title = io.read()
        io.write("Enter author: ")
        local author = io.read()
        io.write("Enter year: ")
        local year = io.read("*n")
        local book = Book:new(title, author, year)
        myLibrary:addBook(book)
        print("Book added successfully.")

    elseif choice == 2 then
        io.write("Enter title: ")
        local title = io.read()
        local book = myLibrary:findBookByTitle(title)
        if book then
            book:display()
        else
            print("Book not found.")
        end

    elseif choice == 3 then
        io.write("Enter author: ")
        local author = io.read()
        local book = myLibrary:findBookByAuthor(author)
        if book then
            book:display()
        else
            print("Book not found.")
        end

    elseif choice == 4 then
        io.write("Enter title: ")
        local title = io.read()
        myLibrary:lendBook(title)

    elseif choice == 5 then
        io.write("Enter title: ")
        local title = io.read()
        myLibrary:returnBook(title)

    elseif choice == 6 then
        myLibrary:displayBooks()

    elseif choice == 7 then
        break

    else
        print("Invalid choice, please try again.")
    end
end

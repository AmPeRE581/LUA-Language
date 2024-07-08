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
        print("Libro '" .. Titolo .. "' è stato ritornato indietro alla libreria.")
    else
        print("Libro '" .. Titolo .. "' non è stato ritornato indietro alla libreria.")
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
    print("\nSistema di gestione della libreria")
    print("1. Aggiungi un libro")
    print("2. Cerca un libro per titolo")
    print("3. Cerca un libro per autore")
    print("4. Presta un libro")
    print("5. Ritorna indietro il libro")
    print("6. Mostra tutti i libri")
    print("7. Esci")
    io.write("Seleziona un opzione: ")
    local choice = io.read("*n")

    if choice == 1 then
        io.write("Inserisca il titolo: ")
        local title = io.read()
        io.write("Inserisca l'autore: ")
        local author = io.read()
        io.write("Inserisca l'anno: ")
        local year = io.read("*n")
        local book = Book:new(title, author, year)
        myLibrary:addBook(book)
        print("Libro aggiunto con successo.")

    elseif choice == 2 then
        io.write("Inserisca il titolo: ")
        local title = io.read()
        local book = myLibrary:findBookByTitle(title)
        if book then
            book:display()
        else
            print("Libro non trovato.")
        end

    elseif choice == 3 then
        io.write("Inserisca l'autore: ")
        local author = io.read()
        local book = myLibrary:findBookByAuthor(author)
        if book then
            book:display()
        else
            print("Libro non trovato.")
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
        print("Scelta non valida, si prega di riprovare.")
    end
end

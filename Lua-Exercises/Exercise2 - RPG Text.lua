-- Funzione per creare un nuovo personaggio
function crea_personaggio(nome)
    return {
        nome = nome,
        salute = 100,
        attacco = 10,
        difesa = 5,
        esperienza = 0,
        livello = 1
    }
end

-- Funzione per creare un nuovo nemico
function crea_nemico(livello)
    return {
        nome = "Nemico di livello " .. livello,
        salute = livello * 20,
        attacco = livello * 5,
        difesa = livello * 2
    }
end

-- Funzione per il combattimento
function combattimento(giocatore, nemico)
    print("Inizia il combattimento tra " .. giocatore.nome .. " e " .. nemico.nome .. "!")
    while giocatore.salute > 0 and nemico.salute > 0 do
        -- Turno del giocatore
        print(giocatore.nome .. " Attacca!")
        danno = math.max(0, giocatore.attacco - nemico.difesa)
        nemico.salute = nemico.salute - danno
        print(nemico.nome .. " subisce " .. danno .. " danni. Salute rimanente: " .. nemico.salute)

        if nemico.salute <= 0 then
            print(nemico.nome .. " è stato sconfitto!")
            giocatore.esperienza = giocatore.esperienza + (nemico.livello * 10)
            print(giocatore.nome .. " guadagna " .. (nemico.livello * 10) .. " esperienza.")
            if giocatore.esperienza >= giocatore.livello * 100 then
                giocatore.livello = giocatore.livello + 1
                giocatore.salute = giocatore.salute + 20
                giocatore.attacco = giocatore.attacco + 5
                giocatore.difesa = giocatore.difesa + 2
                print(giocatore.nome .. " sale di livello! Livello attuale: " .. giocatore.livello)
            end
            break
        end

        -- Turno del nemico
        print(nemico.nome .. " Attacca!")
        danno = math.max(0, nemico.attacco - giocatore.difesa)
        giocatore.salute = giocatore.salute - danno
        print(giocatore.nome .. " subisce " .. danno .. " danni. Salute rimanente: " .. giocatore.salute)

        if giocatore.salute <= 0 then
            print(giocatore.nome .. " è stato sconfitto!")
            break
        end
    end
end

-- Funzione principale del gioco
function gioco()
    io.write("Inserisci il nome del tuo personaggio: ")
    local nome = io.read()
    local giocatore = crea_personaggio(nome)

    while giocatore.salute > 0 do
        print("Un nuovo nemico appare!")
        local nemico = crea_nemico(giocatore.livello)
        combattimento(giocatore, nemico)

        if giocatore.salute > 0 then
            print("Vuoi continuare a combattere? (si/no)")
            local scelta = io.read()
            if scelta ~= "si" then
                break
            end
        end
    end

    print("Gioco terminato. Grazie per aver giocato!")
end

-- Avvia il gioco
gioco()

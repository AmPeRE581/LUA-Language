math.randomseed(os.time())

function play_game(max_attempts, min_val, max_val)
    local numero = math.random(min_val, max_val)
    local tentativi = 0
    print(string.format("Indovina il numero tra %d e %d:", min_val, max_val))

    while tentativi < max_attempts do
        local guess = tonumber(io.read())
        tentativi = tentativi + 1

        if not guess then
            print("Inserisci un numero valido!")
        elseif guess > numero then
            print("Troppo alto! Riprova:")
        elseif guess < numero then
            print("Troppo basso! Riprova:")
        else
            print(string.format("Esatto! Hai indovinato in %d tentativi.", tentativi))
            break
        end

        if tentativi == max_attempts then
            print(string.format("Hai superato il numero massimo di tentativi. Il numero era %d.", numero))
        end
    end
end

function main()
    print("Benvenuto al gioco dell'Indovina Numero!")
    print("In questo gioco, devi indovinare un numero compreso in un intervallo specificato.")
    print("Puoi scegliere un livello di difficoltà o un intervallo personalizzato.")
    print("Hai un numero limitato di tentativi per indovinare il numero corretto.")
    print("Buona fortuna!")

    while true do
        print("\nSeleziona il livello di difficoltà:")
        print("1. Facile (1-50)")
        print("2. Medio (1-100)")
        print("3. Difficile (1-200)")
        print("4. Personalizzato")
        
        local scelta = io.read()
        local min_val, max_val, max_attempts

        if scelta == '1' then
            min_val = 1
            max_val = 50
            max_attempts = 10
        elseif scelta == '2' then
            min_val = 1
            max_val = 100
            max_attempts = 10
        elseif scelta == '3' then
            min_val = 1
            max_val = 200
            max_attempts = 15
        elseif scelta == '4' then
            print("Inserisci il valore minimo dell'intervallo: ")
            min_val = tonumber(io.read())
            print("Inserisci il valore massimo dell'intervallo: ")
            max_val = tonumber(io.read())
            print("Inserisci il numero massimo di tentativi: ")
            max_attempts = tonumber(io.read())
        else
            print("Scelta non valida. Impostato a livello Medio.")
            min_val = 1
            max_val = 100
            max_attempts = 10
        end

        play_game(max_attempts, min_val, max_val)

        print("Vuoi giocare di nuovo? (s/n): ")
        local giocare_ancora = io.read():lower()
        if giocare_ancora ~= 's' then
            break
        end
    end
end

main()
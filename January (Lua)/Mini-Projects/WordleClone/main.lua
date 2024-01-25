--[[

    Wordle (Console Edition - Lua)
    Dominic R. [@jD2R]

    [Start]: 1/19/24
    [End]:   1/24/24

    [Credits]:

    Wordle is owned by the New York Times and can be found below.
     - https://www.nytimes.com/games/wordle/index.html
    
    The word list used in this program can be found (open source) below.
     - https://github.com/Kinkelin/WordleCompetition/blob/main/data/official/shuffled_real_wordles.txt

]]

file = io.open("words.txt", "r")
words = {}

for line in file:lines() do
   table.insert(words, string.upper(line))
end

file:close()

mystery_word = string.upper(words[math.random(#words)])

word_bank = {}
for _, value in ipairs(words) do
    word_bank[value] = true
end

words = {}

GRAY, GREEN, YELLOW = 90, 92, 93

function colorText(text, color)
    return "\27[" .. (color or 0) .. "m" .. text .. "\27[0m"
end

function drawTable(refTable)
    print(" _________ ")
    print("|         |")
    for i = 1, 6, 1 do
        print("|  " .. (colorWord(refTable[i] or "-----", mystery_word)) .. "  |")
    end
    print("|_________|")
end

function validateGuess(guess)
    return #guess == 5 and word_bank[string.upper(guess)] ~= nil
end

function colorWord(word, target)
    str = {}
    word, target = string.upper(word), string.upper(target)

    for i = 1, #word, 1 do
        char = string.sub(word, i, i)
        if char == string.sub(target, i, i) then
            word = string.sub(word, 0, i - 1) .. "-" .. string.sub(word, i + 1, #word)
            target = string.sub(target, 0, i - 1) .. "-" .. string.sub(target, i + 1, #target)
            str[i] = colorText(char, GREEN)
        end
    end

    for i = 1, #word, 1 do
        char = string.sub(word, i, i)

        if string.find(target, char) ~= nil and char ~= "-" then
            word = string.sub(word, 0, i - 1) .. "-" .. string.sub(word, i + 1, #word)
            str[i] = colorText(char, YELLOW)
        elseif str[i] == nil then
            str[i] = colorText(char, GRAY)
        end
    end


    return table.concat(str, "")

end

function endGameScreen(guesses)
    io.write("\27[2J\27[1;1H")
    drawTable(gameTable)
    print("")

    if guesses >= 6 then
        print("That's too bad! The word was " .. mystery_word .. ".")
        print("Better luck next time :)")
    else
        print("That's right! The word was " .. mystery_word .. ".")
        print("It took you " .. guesses + 1 .. (guesses ~= 0 and " guesses. Nice!" or " guess. Wow!"))
    end
end


counter = 0
gameTable = {}
msg = "\nWelcome to Wordle! Type a five-letter word to start."


while counter < 6 do

    -- setup
    io.write("\27[2J\27[1;1H")

    drawTable(gameTable)
    print(msg)
    
    io.write("Enter a guess: ")
    userGuess = string.upper(io.read())

    if validateGuess(userGuess) then
        if word_bank[userGuess] then
            table.insert(gameTable, userGuess)
            word_bank[userGuess] = false
            msg = ""

            if userGuess == mystery_word then
                break
            end
            counter = counter + 1
        else
            msg = "\nYou already guessed that - try another word."
        end
    else
        msg = "\nThat's not a valid word according to the list."
    end

end

endGameScreen(counter)
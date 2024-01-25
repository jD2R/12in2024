math.randomseed(os.time())

num = 0
guesses = 1
secret = math.random(100)

io.write("Guess a number: ")
num = tonumber(io.read())

while num ~= secret do

    if num == nil then
        print("That's not a valid integer!")
    elseif num > secret then
        print("That's too high, try again.")
        guesses = guesses + 1
    else
        print("That's too low, try again.")
        guesses = guesses + 1
    end

    io.write("Guess another number: ")
    num = tonumber(io.read())
end

if guesses == 1 then
    print("You got it! It took you 1 guess, wow!")
else
    print("You got it! It took you " .. guesses .. " guesses.")
end
letter_str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
number_str = "0123456789"
character_str = "!#$%&()*+,-./:;<=>?@[]^_`{|}~"

function createPassword(length, numbers, characters)
    password = ""
    options = letter_str

    if numbers then options = options .. number_str end
    if characters then options = options .. character_str end

    for i = 0, length, 1 do
        index = math.random(1, #options)
        token = string.sub(options, index, index)
        password = password .. (math.random() < 0.5 and token or string.lower(token))
    end

    return password
end


print(createPassword(16, false, false))
print(createPassword(20, true, false))
print(createPassword(30, true, true))

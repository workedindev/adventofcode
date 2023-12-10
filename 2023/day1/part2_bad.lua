-- global sum value
local sum = 0

-- higher order function to generate digit replacement functions
local function replace_spelled_digit(spelled, symbol)
    return function (line)
        line, _ = line:gsub(spelled, symbol)
        return line
    end
end

-- create digit replacement functions
local replace_spelled_one = replace_spelled_digit("one", "1")
local replace_spelled_two = replace_spelled_digit("two", "2")
local replace_spelled_three = replace_spelled_digit("three", "3")
local replace_spelled_four = replace_spelled_digit("four", "4")
local replace_spelled_five = replace_spelled_digit("five", "5")
local replace_spelled_six = replace_spelled_digit("six", "6")
local replace_spelled_seven = replace_spelled_digit("seven", "7")
local replace_spelled_eight = replace_spelled_digit("eight", "8")
local replace_spelled_nine = replace_spelled_digit("nine", "9")
local replace_spelled_zero = replace_spelled_digit("zero", "0")

-- higher order function to find spelled digits
local function find_spelled_digit(spelled)
    return function (line)
        return line:find(spelled)
    end
end

-- create digit finding functions functions
local find_spelled_one = find_spelled_digit("one")
local find_spelled_two = find_spelled_digit("two")
local find_spelled_three = find_spelled_digit("three")
local find_spelled_four = find_spelled_digit("four")
local find_spelled_five = find_spelled_digit("five")
local find_spelled_six = find_spelled_digit("six")
local find_spelled_seven = find_spelled_digit("seven")
local find_spelled_eight = find_spelled_digit("eight")
local find_spelled_nine = find_spelled_digit("nine")
local find_spelled_zero = find_spelled_digit("zero")

-- find spelled out digits
local function find_spelled_digits(line)
    local words = {}

    words[1] = find_spelled_one(line)
    words[2] = find_spelled_two(line)
    words[3] = find_spelled_three(line)
    words[4] = find_spelled_four(line)
    words[5] = find_spelled_five(line)
    words[6] = find_spelled_six(line)
    words[7] = find_spelled_seven(line)
    words[8] = find_spelled_eight(line)
    words[9] = find_spelled_nine(line)
    words[10] = find_spelled_zero(line)

    local index, minimum = nil, nil
    for key, value in pairs(words) do
        if value == nil then
        elseif minimum == nil then
            index, minimum = tonumber(key), tonumber(value)
        elseif tonumber(value) < minimum then
            index, minimum = tonumber(key), tonumber(value)
        end
    end
    -- if index == nil or minimum == nil then
    -- else
    --     print(index)
    --     print(minimum)
    --     print( string.format( "line: %s\tindex: %d\tminimum: %d", line, index, minimum ) )
    -- end
    return index, minimum
end

-- replace spelled out digits
local function replace_spelled_digits(line)
    local index
    repeat
        index, _ = find_spelled_digits(line)
        if index == 1 then
            line = replace_spelled_one(line)
        elseif index == 2 then
            line = replace_spelled_two(line)
        elseif index == 3 then
            line = replace_spelled_three(line)
        elseif index == 4 then
            line = replace_spelled_four(line)
        elseif index == 5 then
            line = replace_spelled_five(line)
        elseif index == 6 then
            line = replace_spelled_six(line)
        elseif index == 7 then
            line = replace_spelled_seven(line)
        elseif index == 8 then
            line = replace_spelled_eight(line)
        elseif index == 9 then
            line = replace_spelled_nine(line)
        elseif index == 10 then
            line = replace_spelled_zero(line)
        end
    until index == nil

    return line
end

-- gets first digit as a string
local function get_digit(line)
    local d1start, d1end = line:find("%d")
    return string.sub(line, d1start, d1end)
end

-- iterate over file line-by-line
for line in io.lines("input.txt") do
    line = replace_spelled_digits(line)
    local d1 = get_digit(line) -- get first digit
    local d2 = get_digit(line:reverse()) -- reverse string and get last digit
    print(string.format("line: %s\td1: %d\td2: %d", line, d1, d2))
    sum = sum + tonumber(d1 .. d2) -- convert concatenated digits and add to global sum
end

-- report final sum
print(sum)

-- global sum value
local sum = 0

-- gets first digit as a string
local function get_digit(line)
    local d1start, d1end = line:find("%d")
    return string.sub(line, d1start, d1end)
end

-- iterate over input line-by-line
for line in io.lines("input.txt") do
    local d1 = get_digit(line) -- get first digit
    local d2 = get_digit(line:reverse()) -- reverse string and get last digit
    sum = sum + tonumber(d1 .. d2) -- convert concatenated digits and add to global sum
end

-- report final sum
print(sum)

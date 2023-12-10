-- global sum value
local sum = 0

CUBES = {
    ["red"] = 12,
    ["green"] = 13,
    ["blue"] = 14
}

-- get game id
local function get_game_id(line)
    -- return game id from format "Game x:"
    local id, _ = string.find(line, ":")
    return id - 6 -- offset "Game :"
end

-- iterate over input line-by-line
for line in io.lines("input.txt") do
    -- get game id
    local id = get_game_id(line)

    local d1 = get_digit(line) -- get first digit
    local d2 = get_digit(line:reverse()) -- reverse string and get last digit
    sum = sum + tonumber(d1 .. d2) -- convert concatenated digits and add to global sum
end

-- report final sum
print(sum)

-- global sum value
local sum = 0

-- preserving part1 values but overwrite with reset_cubes function
CUBES = {
    ["red"] = 12,
    ["green"] = 13,
    ["blue"] = 14
}


local function reset_cubes()
    CUBES = {
        ["red"] = 0,
        ["green"] = 0,
        ["blue"] = 0
    }
end


local function process_pull(pull)
    -- fetch cube color counts
    -- red
    local _, _, red = string.find(pull,"(%d+)%s*red")
    if red == nil then red = 0 else red = tonumber(red) end
    if red > CUBES["red"] then CUBES["red"] = red end

    -- green
    local _, _, green = pull:find("(%d+)%s*green")
    if green == nil then green = 0 else green = tonumber(green) end
    if green > CUBES["green"] then CUBES["green"] = green end

    -- blue
    local _, _, blue = pull:find("(%d+)%s*blue")
    if blue == nil then blue = 0 else blue = tonumber(blue) end
    if blue > CUBES["blue"] then CUBES["blue"] = blue end
end


local function process_game(line)
    -- get index after game id from format "Game x:"
    local id, game_index = line:find(":")

    -- check if id returns nil
    if id == nil then
        print("[WARN] Game id is nil!")
        return 0
    end

    -- get game id
    local game_id = tonumber(line:sub(6, id - 1))

    -- update index to process the game from (after the colon)
    game_index = game_index + 2

    local end_index

    -- reset cubes array
    reset_cubes()

    -- process game by pulls
    repeat
        -- get end index for next pull
        end_index = line:find(";", game_index)

        -- if end index is nil then last pull of game, set end index to end of line
        if end_index == nil then
            end_index = #line
        end

        -- process next pull (operates on global CUBES table)
        process_pull(line:sub(game_index, end_index))

        -- update game index to one past previous pull 
        if end_index then
            game_index = end_index + 1
        end
    until end_index == #line

    return CUBES["red"] * CUBES["green"] * CUBES["blue"]
end

-- iterate over input line-by-line
for line in io.lines("input.txt") do
    -- process game
    local power = process_game(line)

    sum = sum + power -- convert concatenated digits and add to global sum
end

-- report final sum
print(sum)

-- global sum value
local sum = 0

CUBES = {
    ["red"] = 12,
    ["green"] = 13,
    ["blue"] = 14
}


local function clean_string(str)
    str = str:gsub("%s+", "")
    str = str:gsub(";", "")
    return str
end


local function process_pull(pull)
    local success = true
    -- cleanup string to remove excess characters
    pull = clean_string(pull)

    -- fetch cube color counts
    -- red
    local _, _, red = string.find(pull,"(%d+)red")
    if red == nil then red = 0 else red = tonumber(red) end
    if red > CUBES["red"] then success = false end

    -- green
    local _, _, green = pull:find("(%d+)green")
    if green == nil then green = 0 else green = tonumber(green) end
    if green > CUBES["green"] then success = false end

    -- blue
    local _, _, blue = pull:find("(%d+)blue")
    if blue == nil then blue = 0 else blue = tonumber(blue) end
    if blue > CUBES["blue"] then success = false end

    return success
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

    local end_index = nil

    -- process game by pulls
    repeat
        -- get end index for next pull
        end_index = line:find(";", game_index)

        -- if end index is nil then last pull of game, set end index to end of line
        if end_index == nil then
            end_index = #line
        end

        -- process next pull
        local success = process_pull(line:sub(game_index, end_index))
        
        -- pull proved game not valid, return 0 (adds no value to game id sum)
        if not success then
            return 0
        end

        -- update game index to one past previous pull 
        if end_index then
            game_index = end_index + 1
        end
    until end_index == #line

    return game_id
end

-- iterate over input line-by-line
for line in io.lines("input.txt") do
    -- process game
    local success = process_game(line)

    sum = sum + success -- convert concatenated digits and add to global sum
end

-- report final sum
print(sum)

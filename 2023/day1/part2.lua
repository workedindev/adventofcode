-- global sum value
local sum = 0

local NAMES = {
    ["one"] = 1,
    ["two"] = 2,
    ["three"] = 3,
    ["four"] = 4,
    ["five"] = 5,
    ["six"] = 6,
    ["seven"] = 7,
    ["eight"] = 8,
    ["nine"] = 9,
    ["zero"] = 0,
}

-- get left digit
local function get_left_digit(line)
    for i = 1, #line, 1 do
        if tonumber(line:sub(i, i)) then
            print(string.format("found %s on left", line:sub(i, i)))
            return tonumber(line:sub(i, i)) * 10
        else
            for num, value in pairs(NAMES) do
                if num == line:sub(i, i + #num - 1) then
                    print(string.format("found %s on left", num))
                    return value * 10
                end
            end
        end
    end
end

-- get right digit
local function get_right_digit(line)
    for i = #line, 1, -1 do
        if tonumber(line:sub(i, i)) then
            print(string.format("found %s on right", line:sub(i, i)))
            return tonumber(line:sub(i, i))
        else
            for num, value in pairs(NAMES) do
                if num == line:sub(i - #num + 1, i) then
                    print(string.format("found %s on right", num))
                    return value
                end
            end
        end
    end
end

-- iterate over input line-by-line
for line in io.lines("input.txt") do
    print(line)
    sum = sum + get_left_digit(line) + get_right_digit(line)
end

-- report final sum
print(sum)

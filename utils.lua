function UUID()
    local fn = function(x)
        local r = love.math.random(16) - 1
        r = (x == "x") and (r + 1) or (r % 4) + 9
        return ("0123456789abcdef"):sub(r, r)
    end
    return (("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"):gsub("[xy]", fn))
end

function goToRoom(room_type, ...)
    if current_room and current_room.destroy then current_room:destroy() end
    current_room = _G[room_type](...)
	current_room.name = room_type
end

function initialiseFiles()
    local class_list = {}
    recursiveEnumerate("classes", class_list)
    requireFiles(class_list)
end

function initialiseFonts()
    local font_list = {}
    recursiveEnumerate("resources/fonts", font_list)
    return loadFonts(font_list)
end

function recursiveEnumerate(folder, file_list)
    print("searching " .. folder)
    local items = love.filesystem.getDirectoryItems(folder)
    for i, item in ipairs(items) do
        local file = folder .. "/" .. item
        local info = love.filesystem.getInfo(file)
        print("checking " .. file .. " type: " .. info.type)
        if info.type == "file" then
            table.insert(file_list, file)
        elseif info.type == "directory" then
            recursiveEnumerate(file, file_list)
        end
    end
end

function requireFiles(file_list)
    while #file_list > 0 do
        for i=#file_list, 1, -1 do
            local file = file_list[i]
            if pcall(require, file:sub(1,-5)) then
                print("requiring " .. file)
                table.remove(file_list, i)
            else 
                package.loaded[file:sub(1,-5)] = nil
            end
        end
    end
end

function loadFonts(file_list)
    local fonts = {}
    while #file_list > 0 do
        for i=#file_list, 1, -1 do
            local file = file_list[i]
            local filename = file:sub(1, -5)
            filename = filename:gsub("resources/fonts/", "")
            filename = filename .. "_16"
            print("loading font " .. filename)
            fonts[filename] = love.graphics.newFont(file, 16)
            table.remove(file_list, i)
        end
    end
    return fonts
end

function random(min, max)
    local min, max = min or 0, max or 1
    return (min > max and (love.math.random()*(min - max) + max)) or (love.math.random()*(max - min) + min)
end

function pushRotate(x, y, r)
    love.graphics.push()
    love.graphics.translate(x, y)
    love.graphics.rotate(r or 0)
    love.graphics.translate(-x, -y)
end

function pushRotateScale(x, y, r, sx, sy)
    love.graphics.push()
    love.graphics.translate(x, y)
    love.graphics.rotate(r or 0)
    love.graphics.scale(sx or 1, sy or sx or 1)
    love.graphics.translate(-x, -y)
end

function slow(amount, duration)
    slow_amount = amount
    timer:tween(duration, _G, {slow_amount = 1}, "in-out-cubic", "slow")
end

function flash(frames)
    flash_frames  = frames
end

function table.random(t)
    return t[love.math.random(1, #t)]
end


function chanceList(...)
    return {
        chance_list = {},
        chance_definitions = {...},
        next = function(self)
            if #self.chance_list == 0 then
                for _, chance_definition in ipairs(self.chance_definitions) do
                    for i=1, chance_definition[2] do
                        table.insert(self.chance_list, chance_definition[1])
                    end
                end
            end
            return table.remove(self.chance_list, love.math.random(1, #self.chance_list))
        end
    }
end

function distance(x1, y1, x2, y2)
    return math.sqrt((x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2))
end

function table.merge(t1, t2)
    local new_table = {}
    for k,v in pairs(t2) do new_table[k] = v  end
    for k,v in pairs(t1) do new_table[k] = v end
    return new_table
end

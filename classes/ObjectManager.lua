ObjectManager = Object:extend()

function ObjectManager:new(room)
    self.room = room
    self.objects = {}
end

function ObjectManager:update(dt)
    if #self.objects >= 1 then
        for i=1, #self.objects do
            local game_object = self.objects[i]
            game_object:update(dt)
            if game_object.dead then
                game_object = nil
                table.remove(self.objects, i)
            end
        end
    end
end

function ObjectManager:draw()
    if #self.objects >= 1 then
        for i=1, #self.objects do
            self.objects[i]:draw()
        end
    end
end

function ObjectManager:addGameObject(object_name, x, y, args)
    local extra_args = args or {}
    if _G[object_name] then
        local game_object = _G[object_name](self, x or 0, y or 0, extra_args)
        table.insert(self.objects, game_object)
        return game_object
    end
end

function ObjectManager:getGameObjects(func)
    return M.select(self.objects, func)
end

function ObjectManager:queryCircleArea(x, y, radius)
    return self:getGameObjects(function(e)
        local distance = math.sqrt((e.x - x)^2 + (e.y - y)^2) -- checking if top left corner of target is in circle
        if distance < radius then
            return true
        end
        distance = math.sqrt((e.x + e.w - x)^2 + (e.y - y)^2) -- checking if top right corner of target is in circle
        if distance < radius then 
            return true
        end
        distance = math.sqrt((e.x - x)^2 + (e.y + e.h - y)^2) -- checking if bottom left corner of target is in circle
        if distance < radius then
            return true
        end
        distance = math.sqrt((e.x + e.w - x)^2 + (e.y + e.h - y)^2) -- checking if bottomg right corner of target is in circle
        if distance < radius then
            return true
        end
    end)
end
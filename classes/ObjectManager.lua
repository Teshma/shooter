ObjectManager = Object:extend()

function ObjectManager:new(room)
    self.room = room
    self.objects = {}
end

function ObjectManager:update(dt)
    if #self.objects >= 1 then
        for i=1, #self.objects do
            local game_object = self.objects[i]
            if game_object then
                if game_object.alive == false then
                    print(game_object, "destroy")
                    game_object = nil                   
                    table.remove(self.objects, i)
                else
                    game_object:update(dt)
                end
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
    if args then
        for k,v in pairs(args) do
            --print(k, v)
        end
    end
    if _G[object_name] then
        local game_object = _G[object_name](self, x or 0, y or 0, args or {})
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
        distance = math.sqrt((e.x + e.w - x)^2 + (e.y + e.h - y)^2) -- checking if bottom right corner of target is in circle
        if distance < radius then
            return true
        end
    end)
end

function ObjectManager:destroy()
	while #self.objects > 0 do
		print(#self.objects)
		local game_object = self.objects[#self.objects]
		if game_object then
			print(game_object, "destroy")
			game_object = nil                   
			table.remove(self.objects, #self.objects)
		end
	end
	print(#self.objects)
	self.objects = nil
	self.room = nil
end
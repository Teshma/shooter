Stage = Object:extend()

function Stage:new()
	self.map = sti("resources/level1.lua")
	--local player_spawn = self.map:getObjectProperties("Player", "Player Spawn")
	self.colliders = {}
	local player_spawn
	local enemy_spawn
	local patrol_point_table = {}
	for k, object in pairs(self.map.objects) do
		if object.name == "Player Spawn" then
			player_spawn = object
		end
		if object.name == "Enemy" then
			enemy_spawn = object
		end
		if object.name == "PatrolPoint" then
			table.insert(patrol_point_table, {object.x, object.y})
		end
	end
	
    self.ObjectManager = ObjectManager(self)
	self:spawnMapCollisions()
    self.player = self.ObjectManager:addGameObject("Player", player_spawn.x or 0, player_spawn.y or 0)
    local enemy = self.ObjectManager:addGameObject("Enemy", enemy_spawn.x or 50, enemy_spawn.y or 50, {patrol_points = patrol_point_table})
    --self.ObjectManager:addGameObject("Enemy", 100, 100)
    --self.ObjectManager:addGameObject("Enemy", 400, 200, {patrol_points = {{200, 400}, {200, 200}}})
    self.UI = UI(self, self.ObjectManager)
	self:spawnObjects()
end

function Stage:update(dt)
	self.map:update(dt)
    self.ObjectManager:update(dt)
    self.UI:update(dt)
	self:handleCollisions(dt)
	
end

function Stage:draw()
	self.map:draw()
    self.ObjectManager:draw()
    self.UI:draw()
	if debug then
		for i,collider in ipairs(self.colliders) do
			love.graphics.setColor(1, 0, 0)
			collider:draw("line")
			love.graphics.setColor(1, 1, 1)
		end
	end
	
end

function Stage:destroy()
	print("--- destroying stage ---")
	self.ObjectManager:destroy()
	self.player = nil
	self.UI = nil
	print("--- done ---")
end

function Stage:spawnMapCollisions()
	if self.map == nil then
		return
	end
	for row = 1,9 do
		for collumn = 1, 15 do
			local tile = self.map.layers.wall.data[row][collumn]
			if tile then
				if tile.objectGroup then
					if tile.objectGroup.objects then
						local objects = tile.objectGroup.objects
						if table.getn(objects) > 1 then
							self.ObjectManager:addGameObject(
								"Wall",(collumn-1)*32 + objects[1].x, (row-1)*32 + objects[1].y, {width = objects[1].width, height = objects[1].height, 
								collider = Collider.rectangle((collumn-1)*32 + objects[1].x, (row-1)*32 + objects[1].y, objects[1].width, objects[1].height)})
							self.ObjectManager:addGameObject(
								"Wall",(collumn-1)*32 + objects[2].x, (row-1)*32 + objects[2].y, {width = objects[2].width, height = objects[2].height, 
								collider = Collider.rectangle((collumn-1)*32 + objects[2].x, (row-1)*32 + objects[2].y, objects[2].width, objects[2].height)})

						else
							self.ObjectManager:addGameObject(
								"Wall",(collumn-1)*32 + objects[1].x, (row-1)*32 + objects[1].y, {width = objects[1].width, height = objects[1].height, 
								collider = Collider.rectangle((collumn-1)*32 + objects[1].x, (row-1)*32 + objects[1].y, objects[1].width, objects[1].height)})
						end
					end
				end
			end
		end
	end	
end

function Stage:handleCollisions(dt)
	-- find collisions for object
	for i, collider in ipairs(self.colliders) do
		local candidates = self.ObjectManager:queryCircleArea(collider.x, collider.y, 16)
		for i,object in ipairs(candidates) do
			if object.collider then
				local collide, dx, dy = self.object.collider:collidesWith(object.collider)
				self.object.dx = dx
				self.object.dy = dy
				if collide then
					object:resolveCollision(self.object, dx, dy)
				end
			end
		end
	end
end

function Stage:spawnObjects()
	if self.map then

	end
end

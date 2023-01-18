Stage = Object:extend()

function Stage:new()
	self.map = sti("resources/level1.lua")
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
    self.UI = UI(self, self.ObjectManager)
end

function Stage:update(dt)
	self.map:update(dt)
    self.ObjectManager:update(dt)
    self.UI:update(dt)
	
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
	if self.map == nil then return end
	for k, object in pairs(self.map.objects) do
		if object.name == "collision_box" then
			self.ObjectManager:addGameObject("Wall", object.x, object.y, 
			{w = object.width, h = object.height, collider = Collider.rectangle(object.x, object.y, object.width, object.height)})
		end
	end
end

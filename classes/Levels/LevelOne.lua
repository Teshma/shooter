LevelOne = Object:extend()

function LevelOne:new()
	self.colliders = {}
	self.ObjectManager = ObjectManager(self)
	self.ml = MapLoader:new("resources/level1.lua", self.ObjectManager)
	self.ml:spawnMapCollisions()
	self.map = self.ml.map
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
	
    self.player = self.ObjectManager:addGameObject("Player", player_spawn.x or 0, player_spawn.y or 0)
    local enemy = self.ObjectManager:addGameObject("Enemy", enemy_spawn.x or 50, enemy_spawn.y or 50, {patrol_points = patrol_point_table})
    self.UI = UI(self, self.ObjectManager)
end

function LevelOne:update(dt)
	self.map:update(dt)
    self.ObjectManager:update(dt)
    self.UI:update(dt)
	
end

function LevelOne:draw()
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

function LevelOne:destroy()
	print("--- destroying stage ---")
	self.ObjectManager:destroy()
	self.player = nil
	self.UI = nil
	print("--- done ---")
end



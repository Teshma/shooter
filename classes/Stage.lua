Stage = Object:extend()

function Stage:new()
	self.map = sti("resources/level1.lua")
	--local player_spawn = self.map:getObjectProperties("Player", "Player Spawn")
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
    self.player = self.ObjectManager:addGameObject("Player", player_spawn.x or 0, player_spawn.y or 0)
    local enemy = self.ObjectManager:addGameObject("Enemy", enemy_spawn.x or 50, enemy_spawn.y or 50, {patrol_points = patrol_point_table})
	print(enemy.patrol_points)
    --self.ObjectManager:addGameObject("Enemy", 100, 100)
    --self.ObjectManager:addGameObject("Enemy", 800, 200, {patrol_points = {{200, 400}, {200, 200}}})
    self.UI = UI(self, self.ObjectManager)
	self:spawnObjects()
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
	
end

function Stage:destroy()
	print("--- destroying stage ---")
	self.ObjectManager:destroy()
	self.player = nil
	self.UI = nil
	print("--- done ---")
end

function Stage:spawnMapCollisions()
	if self.map then
	end
end
function Stage:spawnObjects()
	if self.map then

	end
end

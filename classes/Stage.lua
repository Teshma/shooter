Stage = Object:extend()

function Stage:new()
	self.map = sti("resources/level1.lua")
    self.ObjectManager = ObjectManager(self)
    self.player = self.ObjectManager:addGameObject("Player", 0, 0)
    --self.ObjectManager:addGameObject("Enemy", 50, 50, {patrol_points = {{60, 100}, {60, 200},{300, 200}}})
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

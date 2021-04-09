Stage = Object:extend()

function Stage:new()
    self.ObjectManager = ObjectManager(self)
    self.player = self.ObjectManager:addGameObject("Player", 50, 50)
    self.ObjectManager:addGameObject("Enemy", 200, 200, {patrol_points = {{500, 500}, {178, 250},{653, 250}}})
    self.ObjectManager:addGameObject("Enemy", 400, 200)
    --self.ObjectManager:addGameObject("Enemy", 800, 200, {patrol_points = {{200, 400}, {200, 200}}})
    self.UI = UI(self, self.ObjectManager)
end

function Stage:update(dt)
    self.ObjectManager:update(dt)
    self.UI:update(dt)
end

function Stage:draw()
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
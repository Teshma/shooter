Stage = Object:extend()

function Stage:new()
    self.ObjectManager = ObjectManager(self)
    self.player = self.ObjectManager:addGameObject("Player", 0, 0)
    self.ObjectManager:addGameObject("Enemy", 50, 50, {patrol_points = {{500/gameWidth, 500/gameHeight}, {178/gameWidth, 250/gameHeight},{653/gameWidth, 250/gameHeight}}})
    self.ObjectManager:addGameObject("Enemy", 100, 100)
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
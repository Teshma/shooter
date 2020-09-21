Stage = Object:extend()

function Stage:new()
    self.ObjectManager = ObjectManager(self)
    self.player = self.ObjectManager:addGameObject("Player", 50, 50)
    self.ObjectManager:addGameObject("Enemy", 200, 200)
    self.ObjectManager:addGameObject("Enemy", 400, 200)
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
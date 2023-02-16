GameplayTest = LevelBase:extend()

function GameplayTest:new()
    GameplayTest.super.new(self, nil)
    self.player = self.ObjectManager:addGameObject("Player", 50, 50)
end

function GameplayTest:update(dt)
    GameplayTest.super.update(self, dt)
end

function GameplayTest:draw()
    GameplayTest.super.draw(self)
end
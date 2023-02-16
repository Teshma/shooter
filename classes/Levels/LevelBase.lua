LevelBase = Object:extend()

function LevelBase:new(mapPath)
    self.ObjectManager = ObjectManager:new(self)
    self.ml = nil
    if mapPath ~= nil then
        self.ml = MapLoader:new(mapPath, self.ObjectManager)
        self.ml:spawnMapCollisions()
        self.map = self.ml.map
    end
end

function LevelBase:update(dt)
    if self.map then self.map:update(dt) end
    self.ObjectManager:update(dt)
end

function LevelBase:draw()
    if self.map then self.map:draw() end
    self.ObjectManager:draw()
end

Player = Object:extend()

function Player:new()
    self.x = 50
    self.y = 50
    self.w = 50
    self.h = 50
    self.v = 400
    self.weapon = Pistol()
    self.collider = Collider.rectangle(self.x, self.y, self.w, self.h)
    self.collider:moveTo(self.x + self.w/2, self.y + self.h/2)
    self.input = Input()
end

function Player:update(dt)
    self.weapon:update(dt)
    if love.keyboard.isDown("d") then
        self.x = self.x + self.v * dt
        self.collider:move(self.v*dt, 0)
    end
    if love.keyboard.isDown("a") then
        self.x = self.x - self.v * dt
        self.collider:move(-1*self.v*dt, 0)
    end
    if love.keyboard.isDown("w") then
        self.y = self.y - self.v * dt
        self.collider:move(0, -1*self.v*dt)
    end
    if love.keyboard.isDown("s") then
        self.y = self.y + self.v * dt
        self.collider:move(0, self.v*dt)
    end
    --self.x, self.y = self.collider:center()
end

function Player:draw()
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
    love.graphics.rectangle("fill", self.x, self.y - 20, (1 - self.weapon.firerate)*100, 10)
    if debug then
        love.graphics.setColor(1, 0, 0)
        self.collider:draw("line")
    end
end

function Player:setInputs()
    self.input:bind("mouse1", "shoot")
    self.input:bind("d", "right")
    self.input:bind("w", "up")
    self.input:bind("a", "left")
    self.input:bind("s", "down")
end
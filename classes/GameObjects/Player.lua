Player = GameObject:extend()

function Player:new(om, x, y, args)
    Player.super.new(self, om, x, y, args)
    self.hitpoints = 100
    self.w = 50
    self.h = 50
    self.v = 400
    self.collision_radius = 50
    self.weapon = nil
    self.collider = Collider.rectangle(self.x, self.y, self.w, self.h)
    self.collider:moveTo(self.x + self.w/2, self.y + self.h/2)
    self:setWeapon("Pistol")
end

function Player:update(dt)
    Player.super.update(self, dt)
    if self.weapon then self.weapon:update(dt) end
    if love.keyboard.isDown("d") then
        self.collider:move(self.v*dt, 0)
    end
    if love.keyboard.isDown("a") then
        self.collider:move(-1*self.v*dt, 0)
    end
    if love.keyboard.isDown("w") then
        self.collider:move(0, -1*self.v*dt)
    end
    if love.keyboard.isDown("s") then
        self.collider:move(0, self.v*dt)
    end
    self.x, self.y = self.collider:center()
    self.x = self.x - self.w/2
    self.y = self.y - self.h/2
    
end

function Player:draw()
    Player.super.draw(self)
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
    love.graphics.rectangle("fill", self.x, self.y - 20, (self.weapon.original_firerate - self.weapon.firerate)*100, 10)
    if debug then
        if self.dx and self.dy then
            love.graphics.line(self.x + self.w/2, self.y + self.h/2, self.x + self.w/2 + 10*self.dx, self.y + self.h/2 + 10*self.dy)
        end
        love.graphics.setColor(1, 0, 0)
        
        self.collider:draw("line")
        love.graphics.setColor(1, 1, 1)
    end
end

function Player:resolveCollision(object, dx, dy)
    Player.super.resolveCollision(self, object, dx, dy)
    
end

function Player:setWeapon(weapon_type)
    self.weapon = self.om:addGameObject(weapon_type, self.x, self.y, {owner = self})
end

function Player:__tostring()
    return "Player"
end
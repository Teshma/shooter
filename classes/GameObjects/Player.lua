Player = GameObject:extend()

function Player:new(om, x, y, args)
    Player.super.new(self, om, x, y, args)
    self.hitpoints = 100
    self.w = 16
    self.h = 16
    self.v = 80
    self.collision_radius = 16
    self.weapon = nil
    self.collider = Collider.rectangle(self.x, self.y, self.w, self.h)
    self.collider:moveTo(self.x + self.w/2, self.y + self.h/2)
    self:setWeapon("Pistol")
	--self.collision_radius = 4 * self.collision_radius
end

function Player:update(dt)
    Player.super.update(self, dt)
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
	self.collision_handler:updateCoords(self.x, self.y)
    
end

function Player:draw()
    Player.super.draw(self)
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
    love.graphics.rectangle("fill", self.x - 5, self.y + self.h , 2, -(self.weapon.original_firerate - self.weapon.firerate)*15)
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
    if object:is(VisionCone) then
        object:onSeePlayer(self.x, self.y)
    end
    if object:is(Enemy) then
        object.collider:move(dx,dy)
    end
end

function Player:takeDamage(damage_value)
    self.hitpoints = math.max(self.hitpoints - damage_value, 0)
    if self.hitpoints <= 0 then
        -- game over/lose life
    end
end

function Player:setWeapon(weapon_type)
    self.weapon = self.om:addGameObject(weapon_type, self.x+self.w/2, self.y+self.h/2, {owner = self})
end

function Player:__tostring()
    return "Player"
end
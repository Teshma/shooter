Enemy = GameObject:extend()
-- need to make a state machine where the enemy can rotate between different states, e.g patrol, standing, attacking with sub states within those
function Enemy:new(om, x, y, args)
    Enemy.super.new(self, om, x, y, args)
    self.w, self.h = 40, 40
    self.hitpoints = 50
    self.v = 200
    self.angle = 0
    self.state = EnemyStates(self)
    self.collision_radius = 40
    self.collider = Collider.rectangle(self.x, self.y, self.w, self.h)
    self.collider:moveTo(self.x, self.y)
end

function Enemy:update(dt)
    Enemy.super.update(self, dt)
    if self.state then self.state:update(dt) end
    self.x, self.y = self.collider:center()
    self.x = self.x - self.w/2
    self.y = self.y - self.h/2

end

function Enemy:draw()
    Enemy.super.draw(self)
    love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
    if debug then
        love.graphics.setColor(1, 0, 0)
        love.graphics.line(self.x + self.w/2, self.y + self.h/2, self.x + self.w/2 + self.v*math.cos(self.angle), self.y + self.h/2 + self.v*math.sin(self.angle))
        self.collider:draw("line")
        love.graphics.setColor(1, 1, 1)
    end
end

function Enemy:move(x, y, dt)
    self.angle = math.atan2(self.y - y, self.x - x) -- calculate angle to x and y point
    self.collider:move(-self.v*math.cos(self.angle)*dt, -self.v*math.sin(self.angle)*dt) -- increase x and y value towards x and y point along the angle
end

function Enemy:rotate(angle)

end

function Enemy:takeDamage(damage_value)
    self.hitpoints = math.max(self.hitpoints - damage_value, 0)
    if self.hitpoints <= 0 then
        self:die()
    end
end

function Enemy:resolveCollision(object, dx, dy)
    Enemy.super.resolveCollision(self, object, dx, dy)
    if object:is(Player) then
        object.collider:move(dx,dy)
    end
    if object:is(Enemy) then
        object.collider:move(dx,dy)
    end
end

function Enemy:__tostring()
    return "Enemy"
end
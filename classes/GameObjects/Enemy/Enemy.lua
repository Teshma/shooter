Enemy = GameObject:extend()
-- need to make a state machine where the enemy can rotate between different states, e.g patrol, standing, attacking with sub states within those
function Enemy:new(om, x, y, args)
    Enemy.super.new(self, om, x, y, args)
    self.w, self.h = 40, 40
    self.hitpoints = 50
    self.v = 200
    self.angle = 0
    self.moving = false
    self.stand_time = 2
    self.collision_radius = 40
    self.collider = Collider.rectangle(self.x, self.y, self.w, self.h)
    self.collider:moveTo(self.x, self.y)
    self.vision = VisionCone(om, self.x + self.w/2, self.y + self.h/2, {owner = self})
    self.state = EnemyStates(self)
end

function Enemy:update(dt)
    Enemy.super.update(self, dt)
    if self.state then self.state:update(dt) end
    if self.vision then self.vision:update(dt) end
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
        self.vision:draw()
        if self.patrol_points then
            for i,v in ipairs(self.patrol_points) do
                love.graphics.circle("fill", v[1], v[2], 5)
            end
        end
        if self.patrol_points and self.state.patrolling_state.moving then love.graphics.print(self.state.patrolling_state.next_point[1] .. " " .. self.state.patrolling_state.next_point[2], self.x, self.y - 40) end
        love.graphics.setColor(1, 1, 1)
    end
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

function Enemy:setPatrolPoints(patrol_points)
    self.patrol_points = patrol_points
    self.state:refresh(self)
end

function Enemy:__tostring()
    return "Enemy"
end
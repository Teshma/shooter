Bullet = GameObject:extend()

function Bullet:new(om, x, y, args)
    Bullet.super.new(self, om, x, y, args)
    self.w, self.h = 8, 4
    self.r = args.r
    self.v = 20
    self.damage = 25
    
    self.collision_radius = 20
    self.collider = Collider.rectangle(self.x, self.y, self.w, self.h)
end

function Bullet:update(dt)
    Bullet.super.update(self, dt)
    --[[ self.x = self.x + self.v*math.cos(self.r) * dt
    self.y = self.y + self.v*math.sin(self.r) * dt ]]
    self.collider:move(self.v*math.cos(self.r)*dt, self.v*math.sin(self.r)*dt)
	self.x, self.y = self.collider:center()
	self.x = self.x - self.w/2
    self.y = self.y - self.h/2

	
end

function Bullet:draw()
    Bullet.super.draw(self)
    love.graphics.setColor(1, 1, 1)
	pushRotate(self.x, self.y, self.r)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
	if debug then
		love.graphics.setColor(1, 0 ,0)
		self.collider:draw("fill")
		love.graphics.setColor(1, 1, 1)
	end
	love.graphics.pop()
end

function Bullet:resolveCollision(object, dx, dy)
    if self.owner:is(Enemy) then
        if object:is(Player) then
            object:takeDamage(self.damage)
            self:die()
        end
    end
    if self.owner:is(Player) then
        if object:is(Enemy) then
            object:takeDamage(self.damage)
            self:die()
        end
    end
end

function Bullet:__tostring()
    return "Bullet"

end
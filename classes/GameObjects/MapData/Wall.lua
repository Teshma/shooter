Wall = GameObject:extend()

function Wall:new(om, x, y, args)
	Wall.super.new(self, om, x, y, args)
	
end

function Wall:update(dt)
	Wall.super.update(self)
end

function Wall:draw()
	Wall.super.draw(self)
	if debug then
		if self.collider then
			love.graphics.setColor(1, 0, 0)
			self.collider:draw("line")
			love.graphics.setColor(1, 1, 1)
		end
	end
end

function Wall:resolveCollision(object, dx, dy)
    Wall.super.resolveCollision(self, object, dx, dy)
	if object:is(Bullet) then
		object:die()
	end
    object.collider:move(dx,dy)

end

function Wall:__tostring()
	return "Wall"
end
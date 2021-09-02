Wall = GameObject:extend()

function Wall:new(om, x, y, args)
	Wall.super.new(self, om, x, y, args)

end

function Wall:update(dt)

end

function Wall:draw()
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
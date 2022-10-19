CollisionHandler = Object:extend()

function CollisionHandler:new(object, om, x_offset, y_offset)
    -- object to handle collisions of
    self.object = object
    self.om = om
    self.x = object.x
    self.y = object.y
	self.x_offset = x_offset or self.object.w/2
	self.y_offset = y_offset or self.object.h/2
end

function CollisionHandler:update(dt)
	self.x = self.object.x
    self.y = self.object.y
    -- find collisions for object
    local candidates = self.om:queryCircleArea(self.x + self.x_offset, self.y + self.y_offset, self.object.collision_radius)
    for i,object in ipairs(candidates) do
		if debug then
			if self.object:is(Player) and object:__tostring() == "Wall" then
				print(i, object)
			end
		end
        if object.collider then
            local collide, dx, dy = self.object.collider:collidesWith(object.collider)
            self.object.dx = dx
            self.object.dy = dy
            if collide then
				if debug then
					--print(self.object, object)
				end
                self.object:resolveCollision(object, -dx, -dy)
            end
        end
    end
end

function CollisionHandler:draw()
	love.graphics.print(self.object:__tostring() .. " " .. tostring(self.x_offset) .. " " .. tostring(self.y_offset), self.x, self.y, 0, 1, 1, 0, 15)
    love.graphics.circle("fill", self.x + self.x_offset, self.y + self.y_offset, 1)
    love.graphics.circle("line", self.x + self.x_offset, self.y + self.y_offset, self.object.collision_radius)
    
end

function CollisionHandler:updateCoords(x, y)
    self.x = x
    self.y = y
end
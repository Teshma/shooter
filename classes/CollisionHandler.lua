CollisionHandler = Object:extend()

function CollisionHandler:new(object, om)
    -- object to handle collisions of
    self.object = object
    self.om = om
    self.x = nil
    self.y = nil
end

function CollisionHandler:update(dt)
    -- find collisions for object
    local candidates = self.om:queryCircleArea(self.object.x + self.object.w/2,self.object.y + self.object.h/2, self.object.collision_radius)
    for i,object in ipairs(candidates) do
		if debug and self.object:is(Player) and object:__tostring() == "Wall" then
			print(i, object)
		end
        if object.collider then
            local collide, dx, dy = self.object.collider:collidesWith(object.collider)
            self.object.dx = dx
            self.object.dy = dy
            if collide then
                object:resolveCollision(self.object, dx, dy)
            end
        end
    end
end

function CollisionHandler:draw()
    love.graphics.circle("line", self.object.x + self.object.w/2,self.object.y + self.object.h/2, self.object.collision_radius)
    
end

function CollisionHandler:updateCoords(x, y)
    self.x = x
    self.y = y
end
GameObject = Object:extend()

function GameObject:new(om, x, y, args)
    self.om = om
    self.uuid = UUID()
    self.x = x
    self.y = y
    self.w = 8
    self.h = 8
    self.alive = true
    self.collision_radius = 16
    self.timer = Timer()
    if args then
        for k,v in pairs(args) do
            self[k] = v
        end
    end
	self.collision_handler = CollisionHandler(self, om, self.x_offset or nil, self.y_offset or nil)
	self.registered = false
end

function GameObject:update(dt)
    if self.collision_handler then
		self.collision_handler:update(dt) 
	end
    if self.timer then self.timer:update(dt) end
end

function GameObject:draw()
    if debug then
		love.graphics.setColor(0, 1, 0)
        self.collision_handler:draw()
		love.graphics.setColor(1, 1, 1)
    end

end

function GameObject:resolveCollision(object, dx, dy)
    -- default functionality
end

function GameObject:die()
    self.alive = false
end
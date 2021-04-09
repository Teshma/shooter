GameObject = Object:extend()

function GameObject:new(om, x, y, args)
    self.om = om
    self.uuid = UUID()
    self.x = x
    self.y = y
    self.w = 4
    self.h = 4
    self.alive = true
    self.collision_radius = 5
    self.collision_handler = CollisionHandler(self, om)
    self.timer = Timer()
    if args then
        for k,v in pairs(args) do
            self[k] = v
        end
    end
end

function GameObject:update(dt)
    if self.collision_handler then self.collision_handler:update(dt) end
    if self.timer then self.timer:update(dt) end
end

function GameObject:draw()
    if debug then
        self.collision_handler:draw()
    end

end

function GameObject:resolveCollision(object, dx, dy)
    -- default functionality
end

function GameObject:die()
    self.alive = false
end
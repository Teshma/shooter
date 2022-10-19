VisionCone = GameObject:extend()

function VisionCone:new(om, x, y, args)
    VisionCone.super.new(self, om, x, y, args)
    self.owner = self.owner or nil
    self.w, self.h = 64, 64
    self.angle = self.owner.angle
    self.collision_radius = 64
    self.player_x = nil
    self.player_y = nil
    local widthRadius = self.w / 2
    local heightRadius = self.h / 2
	local x_offset = self.owner.w/2
	local y_offset = self.owner.h/2
    local x1 = self.x
    local y1 = self.y 
    local x2 = self.x + self.w
    local y2 = self.y + self.h/2
    local x3 = self.x + self.w
    local y3 = y2 - self.h
    self.collider = Collider.polygon(x1, y1, x2, y2, x3, y3)
end

function VisionCone:update(dt)
    VisionCone.super.update(self, dt)
    if self.owner then self.angle = self.owner.angle end
    self.x = self.owner.x
    self.y = self.owner.y
    self.collider:moveTo(self.x + self.owner.w/2 + 5*self.w/8*math.cos(self.angle), self.y + self.owner.h/2 + 5*self.w/8*math.sin(self.angle))
    --self.collision_handler:updateCoords(self.x + 5*self.w/8*math.cos(self.angle), self.y + 5*self.h/8*math.sin(self.angle))
    self.collider:setRotation(self.angle)
end

function VisionCone:draw()
	VisionCone.super.draw(self)
    self.collider:draw()
    if debug then
		love.graphics.setColor(1, 0, 1)
        --self.collision_handler:draw()
		love.graphics.setColor(1, 1, 1)
    end
end

function VisionCone:resolveCollision(object, dx, dy)
    VisionCone.super.resolveCollision(object, dx, dy)
	if object:is(Player) then
		self:onSeePlayer(object.x, object.y)
	end
end

function VisionCone:onSeePlayer(x, y)
    if not self.owner.state.current_state:is(AlertState) then
        self.owner.state:setState("Alert")
        self.player_x = x
        self.player_y = y
    end
end

function VisionCone:__tostring()
	return "VisionCone " .. self.uuid
end
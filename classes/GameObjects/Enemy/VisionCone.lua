VisionCone = GameObject:extend()

function VisionCone:new(om, x, y, args)
    VisionCone.super.new(self, om, x, y, args)
    self.owner = self.owner or nil
    self.w, self.h = 200, 200
    self.angle = self.owner.angle
    local widthRadius = self.w / 2
    local heightRadius = self.h / 2
    local x1 = self.x
    local y1 = self.y 
    local x2 = self.x + self.w
    local y2 = self.y + self.h/2
    local x3 = self.x + self.w
    local y3 = y2 - self.h
    self.collider = Collider.polygon(x1, y1, x2, y2, x3, y3)
    
    
end

function VisionCone:update(dt)
    if self.owner then self.angle = self.owner.angle end
    self.x = self.owner.x + self.owner.w/2
    self.y = self.owner.y + self.owner.h/2
    self.collider:moveTo(self.x + 5*self.w/8*math.cos(self.angle), self.y + 5*self.h/8*math.sin(self.angle))
    self.collider:setRotation(self.angle)
end

function VisionCone:draw()
    
    self.collider:draw()
    
end

function VisionCone:resolveCollision(object, dx, dy)
    VisionCone.super.resolveCollision(object, dx, dy)
    if obj:is(Player) then
        print("spooky")
    end
end
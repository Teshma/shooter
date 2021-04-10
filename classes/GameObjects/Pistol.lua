Pistol = GameObject:extend()

function Pistol:new(om, x, y, args)
    Pistol.super.new(self, om, x, y, args)
    self.original_firerate = 0.5
    self.firerate = self.original_firerate
    self.owner = args.owner
    self.shot = false
end

function Pistol:update(dt)
    if self.shot then self.firerate = self.firerate - dt end
    if self.firerate <= 0 then 
        self.shot = false
        self.firerate = self.original_firerate
    end
    self.x = self.owner.x + self.owner.w/4
    self.y = self.owner.y + self.owner.h/4
end

function Pistol:draw()
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

function Pistol:shoot(x, y)
    if self.shot then return end
    local delta_y = y - self.y
    local delta_x = x - self.x
    local r = math.atan2(delta_y, delta_x)
    self.om:addGameObject("Bullet", self.x, self.y, {r = r, owner = self.owner})
    self.shot = true
    --fire projectile at mouse cursor
end

function Pistol:__tostring()
    return "Pistol"
end
Pistol = Object:extend()

function Pistol:new(x, y)
    self.x = x
    self.y = y
    self.firerate = 1
    self.shot = false
end

function Pistol:update(dt)
    if self.shot then self.firerate = self.firerate - dt end
    if self.firerate <= 0 then 
        self.shot = false
        self.firerate = 1
    end
end

function Pistol:draw()

end

function Pistol:shoot(x, y)
    if self.shot then return end
    print("Fire!", x, y)
    self.shot = true
    --fire projectile at mouse cursor
end
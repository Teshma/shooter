Pistol = Object:extend()

function Pistol:new(x, y)
    self.x = x
    self.y = y
end

function Pistol:update(dt)
    if love.mouse.isDown(1) then
        local mx, my = love.mouse.getPosition()
        print("Fire!")
        --fire projectile at mouse cursor
    end
end

function Pistol:draw()

end

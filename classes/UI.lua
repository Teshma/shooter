UI = Object:extend()

function UI:new(room, om)
    self.room = room
    self.om = om

end

function UI:update(dt)

end

function UI:draw()
    love.graphics.setColor(1, 0.1, 0.2)
    love.graphics.rectangle("fill", 10, 10, self.room.player.hitpoints, 10)
    love.graphics.setColor(1, 1, 1)
end
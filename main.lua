function love.load()
    Object = require "libs.classic"
    Collider = require "libs.HC"
    require "utils"
    initialiseFiles()
    player = Player()
end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    player:draw()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function love.load()
    Object = require "libs.classic"
    Collider = require "libs.HC"
    Input = require "libs.input"
    require "utils"
    initialiseFiles()
    player = Player()
    debug = false
    
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
    if key == "0" then
        debug = not debug
    end
end

function love.mousepressed(x, y, button, isTouch)
    if button == 1 then
        player.weapon:shoot(x, y)
    end
end
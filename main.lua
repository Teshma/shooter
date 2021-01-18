function love.load()
    Object = require "libs.classic"
    Collider = require "libs.HC"
    Input = require "libs.input"
    M = require "libs.moses"
    Timer = require "libs.timer"
    Draft = require "libs.draft"
    draft = Draft()
    require "utils"
    initialiseFiles()
    current_room = nil
    goToRoom("Stage")
    debug = false
    
end

function love.update(dt)
    if current_room then current_room:update(dt) end
end

function love.draw()
    if current_room then current_room:draw() end
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
    local player = current_room.player
    if player then
        if button == 1 and player.weapon:is(Pistol) then
            player.weapon:shoot(x, y)
        end
    end
end
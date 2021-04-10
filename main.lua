function love.load()
    Object = require "libs.classic"
    Collider = require "libs.HC"
    Input = require "libs.input"
    M = require "libs.moses"
    Timer = require "libs.timer"
    Draft = require "libs.draft"
	Push = require "libs.push"
	draft = Draft()
    require "utils"
	love.graphics.setDefaultFilter("nearest")
	gameWidth, gameHeight = 432, 243
	windowWidth, windowHeight = 1280, 720
	Push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false, resizable = false,})
    initialiseFiles()
    current_room = nil
    goToRoom("Stage")
    debug = false
    
end

function love.update(dt)
    if current_room then current_room:update(dt) end
end

function love.draw()
	Push:start()
    if current_room then current_room:draw() end
	Push:finish()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    if key == "0" then
        debug = not debug
    end
	if key == "r" then
		goToRoom(current_room.name)
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
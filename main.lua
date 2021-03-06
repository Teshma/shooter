function love.load()
    Object = require "libs.classic"
    Collider = require "libs.HC"
    Input = require "libs.input"
    M = require "libs.moses"
    Timer = require "libs.timer"
    Draft = require "libs.draft"
	Push = require "libs.push"
	sti = require "libs.sti"
	draft = Draft()
    require "utils"
	love.graphics.setDefaultFilter("nearest")
	gameWidth, gameHeight = 480, 288
	windowWidth, windowHeight = 1920, 1080
	Push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = true, resizable = false,})
    initialiseFiles()
    current_room = nil
    goToRoom("Stage")
    debug = false
	pause = false
    
end

function love.update(dt)
	if love.keyboard.isDown("p") then pause = not pause end
	if pause then dt = 0 end
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
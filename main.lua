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
    initialiseFiles()

	love.graphics.setDefaultFilter("nearest", "nearest")
	gameWidth, gameHeight = 480, 288
	windowWidth, windowHeight = love.window.getDesktopDimensions()
	Push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = true, resizable = true,})
    
    current_room = nil
    levelList = {}
    levelList["GameplayTest"] = require "classes.Levels.GameplayTest"
    levelList["LevelOne"] = require "classes.Levels.LevelOne"
    goToRoom("GameplayTest")
    
    debug = false
	pause = false
    
end

function love.update(dt)
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
    if key == "p" then pause = not pause end
end

function love.mousepressed(x, y, button, isTouch)
    local player = current_room.player
    if player then
        if button == 1 and player.weapon:is(Pistol) then
            player.weapon:shoot(x, y)
        end
    end
end
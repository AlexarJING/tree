local scene = Gamestate.new()

function scene:init()
	game=self
	game.temperature= -10
	game.brightness=1
	game.colorful=1
	game.wind=1
	game.bg =require "stage/background"()
	game.fg =require "stage/foreground"()
	game.timer = require "stage/timer"()
	game.weather = require "stage/weather"()
	game.climate= require "stage/climate"
end

function scene:enter()

end

--love.graphics.translate( -1320, -300 )

function scene:draw()
	
	love.graphics.push()
	--love.graphics.scale(0.4, 0.4)
	love.graphics.translate(-2500+250, -1250 )
    game.bg:draw()
    game.fg:draw()	
    love.graphics.pop()
    game.timer:draw()

end

function scene:update(dt)
    game.timer:update(dt)
    game.climate:update(dt)
    game.bg:update(dt)
    game.fg:update(dt)
end 

function scene:leave()
	
end



return scene
local scene = Gamestate.new()

function scene:init()
	game={}
	game.bg =require "stage/background"()
	game.fg =require "stage/foreground"()
	game.timer = require "stage/timer"()
	game.weather = require "stage/weather"()
	game.temperature= 10
end

function scene:enter()

end

--love.graphics.translate( -1320, -300 )

function scene:draw()
	
	love.graphics.push()
	--love.graphics.scale(0.4, 0.4)
	love.graphics.translate(-1800, -1300 )
    game.bg:draw()
    game.fg:draw()	
    love.graphics.pop()
    game.timer:draw()
end

function scene:update(dt)
    game.timer:update(dt)

    game.bg:update(dt)
    game.fg:update(dt)
end 

function scene:leave()
	
end



return scene
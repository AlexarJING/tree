local scene = Gamestate.new()



function scene:init()
	self.bg =require "stage/background"(self)
	self.fg =require "stage/foreground"(self)
	self.timer = require "stage/timer"(self)
end

function scene:enter()

end

--love.graphics.translate( -1320, -300 )

function scene:draw()
	
	love.graphics.push()
	--love.graphics.scale(0.4, 0.4)
	love.graphics.translate(-1800, -1300 )
    self.bg:draw()
    self.fg:draw()	
    love.graphics.pop()
    self.timer:draw()
end

function scene:update(dt)
    self.timer:update(dt)

    self.bg:update(dt)
    self.fg:update(dt)
end 

function scene:leave()
	
end



return scene
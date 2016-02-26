local star=Class("star")
local stageSize=5000
function star:init(bg)
	self.parent=bg
	self.count= count or 500
	self.canvas = love.graphics.newCanvas(stageSize/2,stageSize/2)
	love.graphics.setCanvas(self.canvas)
	for i=1 , self.count do
		love.graphics.setColor(255, 255, 255, lm.random()*100+155)
		love.graphics.points(lm.random()*stageSize/2, lm.random()*stageSize/2)

	end

	love.graphics.setCanvas()

end


function star:update()
	self.x=self.parent.pos*5000/24
end


function star:draw()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(self.canvas, self.x)
	love.graphics.draw(self.canvas, self.x-stageSize/2)
end

return star
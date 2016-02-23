local stageSize=5000
local sky=Class("sky")

function sky:init(bg)
	self.canvas = love.graphics.newCanvas(stageSize, stageSize)
	self.atmos=love.graphics.newMesh(  --渐变 上蓝 中红 下黑 
	{	
		{stageSize/2,stageSize/2,0,0,50,50,200,130},
		{0,0,0,0,100,215,255},
		{stageSize,0,0,0,100,215,255},
		{stageSize,stageSize/2,0,0,200,50,50,200},
		{stageSize,stageSize,0,0,0,0,0},
		{0,stageSize,0,0,0,0,0},
		{0,stageSize/2,0,0,200,50,50,200},
		{0,0,0,0,100,215,255},
	}	
		)
	self.rot=0
	self.parent=bg
	self:initDraw()
end

function sky:initDraw()
	love.graphics.setCanvas(self.canvas)
	

	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(self.atmos)
	
	for i= 1,300 do
		local rad= love.math.random()*2*Pi
		local x= (love.math.random()*2000+500)*math.sin(rad)
		local y= (love.math.random()*2000+500)*math.abs(math.cos(rad))
		love.graphics.setColor(255, 255, 255,100+155*love.math.random())	
		love.graphics.points(x+2500, y+2500)
	end

	love.graphics.setCanvas()

end


function sky:update()

end


function sky:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(self.canvas,2500,2500,self.parent.rot,1,1,2500,2500)
end

return sky
local stageSize=5000
local sky=Class("sky2")

--蓝 100,215,255
--红 200,50,50
--黑 0，0，0


function sky:init(bg)
	self.canvas = love.graphics.newCanvas(stageSize, stageSize/2)
	self.canvas:setWrap( "repeat", "repeat" )
	local p=stageSize
	local vert=
	{	
		{0,	0,	0,0,	255,255,255},
		{0,p/2,	0,0,	255,255,255},
		{p/3,0,	0,0,	255,255,255,0},
		{p/3,p/2,	0,0,	255,255,255,0},
		{p*2/3,0,	0,0,	255,255,255,0},
		{p*2/3,p/2,	0,0,	255,255,255,0},
		{p,	0,	0,0,	255,255,255},
		{p,p/2,	0,0,	255,255,255},

	}
	local vert2=
	{	
		{0,	0,	0,0,	0,150,255},
		{0,p/2,	0,0,	0,150,255},
		{p/3,0,	0,0,	255,0,100,50},
		{p/3,p/2,	0,0,	255,0,100,50},
		{p*2/3,0,	0,0,	255,0,100,50},
		{p*2/3,p/2,	0,0,	255,0,100,50},
		{p,	0,	0,0,	0,150,255},
		{p,p/2,	0,0,	0,150,255},

	}
	self.atmos=love.graphics.newMesh( vert,"strip")
	self.color=love.graphics.newMesh( vert2,"strip")
	--self.rot=0
	self.parent=bg
	self:initDraw()
end

function sky:initDraw()
	love.graphics.setCanvas(self.canvas)
	
	love.graphics.setColor(255,255,255)
	love.graphics.draw(self.atmos)
	--love.graphics.draw(self.color)
	

	for i= 1,300 do
		love.graphics.setColor(255,255,255,100+155*love.math.random())
		love.graphics.points(1250+2500*love.math.random(), 2500*love.math.random())
	end

	
	love.graphics.setCanvas()

end


function sky:update()
	self.x=self.parent.pos*5000/24
end


function sky:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(self.canvas,self.x)
	love.graphics.draw(self.canvas,self.x-5000)
	love.graphics.draw(self.canvas,self.x+5000)
end

return sky
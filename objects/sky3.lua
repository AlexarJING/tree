local stageSize=5000
local sky=Class("sky3")

--蓝 100,215,255
--红 200,50,50
--黑 0，0，0


function sky:init(bg)
	self.canvas = love.graphics.newCanvas(stageSize/2, stageSize/2)

	local p=stageSize
	local vert=
	{	
		{0,	0,	0,0,	255,255,255,255},
		{0,p/2,	0,0,	255,255,255,255,0},
		{p/2,	0,	0,0,	255,255,255},
		{p/2,p/2,	0,0,	255,255,255,0},

	}
	
	self.colorMesh=love.graphics.newMesh( vert,"strip")
	self.color={0,0,0,0}
	self.parent=bg
	--self:initDraw()
end

local colorStep={41,}


function sky:colorCtrl()
	local hour=self.parent.pos
	
	self.color[1]=34*math.abs(12-hour) --205，0
	self.color[2]=160-26*math.abs(12-hour) --0，160
	self.color[3]=255-42*math.abs(12-hour) --0，255
	

	if hour>9 and hour<17 then
		self.brightness=255
	elseif hour>6 and hour<=9 then
		self.brightness=(hour-6)*85
	elseif hour>=15 and hour<18 then
		self.brightness=(18-hour)*85
	else
		self.brightness= 0
	end
end


function sky:updateDraw()
	love.graphics.setCanvas(self.canvas)
	love.graphics.clear()
	self.color[4]=self.brightness
	love.graphics.setColor(self.color)
	love.graphics.rectangle("fill",0,0,stageSize/2, stageSize/2)
	--love.graphics.setColor(255,255,255,self.brightness)
	--love.graphics.rectangle("fill",0,0,stageSize/2, stageSize/2)
	
--[[
	for i= 1,300 do
		love.graphics.setColor(255,255,255,100+155*love.math.random())
		love.graphics.points(1250+2500*love.math.random(), 2500*love.math.random())
	end
]]
	
	love.graphics.setCanvas()

end


function sky:update()
	self:colorCtrl()
	self:updateDraw()
end


function sky:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(self.canvas,stageSize/4)
end

return sky
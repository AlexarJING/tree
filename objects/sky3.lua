local stageSize=5000
local sky=Class("sky3")
--蓝 100,215,255
--红 200,50,50
--黑 0，0，0


function sky:init(bg)
	--self.canvas = love.graphics.newCanvas(stageSize/2, stageSize/2)

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


function sky:colorCtrl()
	local hour=self.parent.pos
	self.color[1]=34*math.abs(12-hour) --205，0
	self.color[2]=160-26*math.abs(12-hour) --0，160
	self.color[3]=255-42*math.abs(12-hour) --0，255
	
	for i=1,3 do
		self.color[i]=self.color[i]+(128-self.color[i])*(1-self.parent.colorful)
	end

	if hour>9 and hour<15 then
		self.brightness=255
	elseif hour>6 and hour<=9 then
		self.brightness=(hour-6)*85
	elseif hour>=15 and hour<18 then
		self.brightness=(18-hour)*85
	else
		self.brightness= 0
	end
	self.color[4]=self.brightness*self.parent.brightness
end



function sky:update()
	self:colorCtrl()
end


function sky:draw()
	love.graphics.setColor(self.color)
	love.graphics.rectangle("fill",stageSize/4,0,stageSize/2, stageSize/2)
end


return sky
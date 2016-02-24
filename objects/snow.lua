local snow=Class("snow")
local stageSize=5000
function snow:init(fg)
	self.parent=fg
	self.height=height or 1100
	self.rad = rad or 1500
	self.thickness = thickness or 1000
	self.wind=  wind or 0
	self.cd =2
	self.timer=0
	self.drops={}
end

function snow:createDrop()
	local drop={
		x=stageSize/2+(0.5-love.math.random())*self.rad,
		y=stageSize/2-self.height,
		vy=0.7,
		vx=self.wind,
		offx=love.math.random()*Pi*2,
		r = 2+love.math.random()*5
	}
	return drop
end


function snow:update()
	if #self.drops<self.thickness then
		if self.cd>1 then
			self.timer=self.timer+1
			if self.timer>self.cd then
				table.insert(self.drops,self:createDrop())
				self.timer=0
			end
		else
			for i=1,1/self.cd do
				table.insert(self.drops,self:createDrop())
			end
		end
	end
	for i,v in ipairs(self.drops) do
		v.y=v.y +v.vy
		v.offx=v.offx+Pi/100
		v.x=v.x+v.vx+math.sin(v.offx)
		if v.y>stageSize/2 or math.getDistance(v.x,v.y,stageSize/2,stageSize/2)<500 then
			table.remove(self.drops, i)
		end
	end
end



function snow:draw()
	love.graphics.setColor(200, 200, 200, 50)
	love.graphics.setLineWidth(1)
	for i,v in ipairs(self.drops) do
		love.graphics.circle("fill", v.x, v.y, v.r, 6)
	end
	
end

return snow
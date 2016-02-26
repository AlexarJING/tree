local rain=Class("rain")
local Lightning= require "objects/lightning"

local stageSize=5000
function rain:init(fg)
	self.parent=fg
	self.height=height or 1100
	self.rad = rad or 1500
	self.thickness = thickness or 10000
	self.wind=  wind or 0
	self.lightning = lightning or 0.1
	self.cd= cd or 1
	self.timer=0
	self.drops={}
	self.lightnings={}
end

function rain:reset(cd,thunder)
	if thunder then self.lightning= thunder end
	if cd then self.cd =5/cd end
end



function rain:createDrop()
	if game.temperature>0 then
		return {
			x=stageSize/2+(0.5-love.math.random())*self.rad,
			y=stageSize/2-self.height,
			vy=3,
			vx=self.wind,
			type="rain"
		}
	else
		return {
			x=stageSize/2+(0.5-love.math.random())*self.rad,
			y=stageSize/2-self.height,
			vy=0.7,
			vx=self.wind,
			offx=love.math.random()*Pi*2,
			r = 2+love.math.random()*5,
			type="snow"
		}
	end
end



function rain:update()

	if self.lightning and love.math.random()>1-self.lightning/10 then  
		table.insert(self.lightnings, Lightning(self))
	end
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
		if v.type=="rain" then
			v.lx=v.x
			v.ly=v.y
			v.vy=v.vy+0.2
			v.y=v.y +v.vy
			v.x=v.x+v.vx
		else
			v.y=v.y +v.vy
			v.offx=v.offx+Pi/100
			v.x=v.x+v.vx+math.sin(v.offx)
		end
		if v.y>stageSize/2 or math.getDistance(v.x,v.y,stageSize/2,stageSize/2)<500 then
			table.remove(self.drops, i)
		end
	end

	for i,v in ipairs(self.lightnings) do
		v:update()
	end
end



function rain:draw()
	love.graphics.setColor(200, 200, 200, 50)
	love.graphics.setLineWidth(1)
	for i,v in ipairs(self.drops) do
		if v.type=="rain" then
			love.graphics.line(v.lx, v.ly, v.x, v.y)
		else
			love.graphics.circle("fill", v.x, v.y, v.r, 6)
		end
	end
	for i,v in ipairs(self.lightnings) do
		v:draw()
	end
end

return rain
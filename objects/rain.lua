local rain=Class("rain")
local Lightning= require "objects/lightning"

local stageSize=5000
function rain:init(fg)
	self.parent=fg
	self.height=height or 1100
	self.rad = rad or 3000
	self.thickness = thickness or 10000
	self.lightning = lightning or 0.1
	self.cd= cd or 1
	self.timer=0
	self.drops={}
	self.lightnings={}
end

function rain:reset(index)
	if index>0.5 then
		self.cd=1/(50^(index-0.5))
		if index>0.7 then
			self.lightning=(index-0.7)*2
		else
			self.lightning=0
		end
	else
		self.cd=1/0
		self.lightning=0
	end
end



function rain:createDrop()
	if game.temperature>0 then
		return {
			x=stageSize/2+(0.5-love.math.random())*self.rad,
			y=stageSize/2-self.height,
			vy=10,
			alpha=love.math.random(20,100),
			type="rain"
		}
	else
		return {
			x=stageSize/2+(0.5-love.math.random())*self.rad,
			y=stageSize/2-self.height,
			vy=1,
			alpha=love.math.random(20,100),
			offx=love.math.random()*Pi*2,
			r = 2+love.math.random()*5,
			type="snow"
		}
	end
end



function rain:update()

	if self.lightning and game.temperature>0 and love.math.random()>1.000-self.lightning/10 then  
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
			v.vy=v.vy
			v.y=v.y +v.vy
			v.x=v.x+game.wind
		else
			v.y=v.y +v.vy
			v.offx=v.offx+Pi/100
			v.x=v.x+game.wind+math.sin(v.offx)
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
	
	for i,v in ipairs(self.drops) do
		love.graphics.setColor(255,255,255,v.alpha)
		love.graphics.setLineWidth(love.math.random(1,2))
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
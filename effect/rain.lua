local rain=Class("rain")
local stageSize=5000
function rain:init(fg)
	self.parent=fg
	self.height=height or 1100
	self.rad = rad or 1500
	self.thickness = thickness or 300
	self.wind=  wind or 3

	self.drops={}
end

function rain:createDrop()
	local drop={
		x=stageSize/2+(0.5-love.math.random())*self.rad,
		y=stageSize/2-self.height,
		vy=3,
		vx=self.wind
	}
	return drop
end


function rain:update()
	if #self.drops<self.thickness then
		for i=1,3 do
			table.insert(self.drops,self:createDrop())
		end
	end
	for i,v in ipairs(self.drops) do
		v.lx=v.x
		v.ly=v.y
		v.vy=v.vy+0.2
		v.y=v.y +v.vy
		v.x=v.x+v.vx
		if v.y>stageSize/2 or math.getDistance(v.x,v.y,stageSize/2,stageSize/2)<500 then
			table.remove(self.drops, i)
		end
	end
end



function rain:draw()
	love.graphics.setColor(200, 200, 200, 50)
	love.graphics.setLineWidth(1)
	for i,v in ipairs(self.drops) do
		love.graphics.line(v.lx, v.ly, v.x, v.y)
	end
	
end

return rain
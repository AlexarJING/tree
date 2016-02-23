local ground=Class("ground")
local stageSize=5000

local function CreateCircle(segments,alpha)
	segments = segments or 40
	alpha = alpha and 0 or 255
	local vertices = {}
	table.insert(vertices, {0, 0})
	for i=0, segments do
		local angle = (i / segments) * math.pi * 2
		local x = math.cos(angle)
		local y = math.sin(angle)
		table.insert(vertices, {x, y,_,_,_,_,_,alpha})
	end
	return love.graphics.newMesh(vertices, "fan")
end

function ground:init()
	self.x=stageSize/2
	self.y=stageSize/2
	self.r=500
	self.shape=CreateCircle(120)
end


function ground:update()


end


function ground:draw()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(self.shape, self.x, self.y, 0, self.r,self.r)
end


return ground
local sun=Class("sun")
local stageSize=5000
local sunPos=1400
local sunRad=45
local function circle(segments,alpha)
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
 

local function glow(segments,r) --大于1外发光 小于1 内发光
	segments = segments or 100
	local vertices = {}
	for i=0, segments do
		local angle = (i / segments) * math.pi * 2
		local x = math.cos(angle)
		local y = math.sin(angle)	
		local x2 =math.cos(angle)*r
		local y2= math.sin(angle)*r
		table.insert(vertices, {x, y})
		table.insert(vertices, {x2, y2,_,_,_,_,_,0})
	end
	table.insert(vertices, {1, 0})
	return love.graphics.newMesh(vertices, "strip")

end

local function aura(segments,alpha)
	segments = segments or 40
	alpha = alpha and 0 or 255
	local x,y,angle
	local vertices = {}
	table.insert(vertices, {0, 0})
	for i=0, segments do
		angle = (i / segments) * math.pi * 2
		x = math.cos(angle)
		y = math.sin(angle)
		table.insert(vertices, {x, y,_,_,_,_,_,alpha})
	end
	return love.graphics.newMesh(vertices, "fan")
end

function sun:init(bg)
	self.parent=bg
	self.r=sunRad
	self.rot=0
	self.body=circle()
	self.inner=glow(_,0.8)
	self.outer=glow(_,2)
	self.aura=aura(_,true)
	self.sunColor={255, 255,255}
	self.glowColor={255,255,200}
	self.auraColor={255,255,255,100}
end

function sun:reset(index)  --0.7-1
	self.r=sunRad*index
end


function sun:update()
	
	self.x,self.y=math.axisRot(0,-sunPos,self.parent.rot)
	self.y=self.y*0.1
	if self.y<0 then
		self.visible=true
	else
		self.visible=false
	end
	self.rot=self.parent.rot
	self.sunColor[2]=255-math.abs(self.x)/24
	self.sunColor[3]=255-math.abs(self.x)/24
	self.glowColor[2]=255-math.abs(self.x)/24
	self.glowColor[3]=200-math.abs(self.x)/24
	self.auraColor[4]=100-math.abs(self.x)/10
end

function sun:draw()
	if not self.visible then return end
	love.graphics.setColor(self.auraColor)
	love.graphics.draw(self.aura, self.x+stageSize/2, self.y+stageSize/3.2, self.rot, self.r*10,self.r*10)
	love.graphics.setColor(self.sunColor)
	love.graphics.draw(self.body, self.x+stageSize/2, self.y+stageSize/3.2, self.rot, self.r,self.r)
	love.graphics.setColor(self.glowColor)
	love.graphics.draw(self.inner, self.x+stageSize/2, self.y+stageSize/3.2, self.rot, self.r,self.r)
	love.graphics.draw(self.outer, self.x+stageSize/2, self.y+stageSize/3.2, self.rot, self.r,self.r)

end


return sun
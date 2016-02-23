local moon=Class("moon")
local stageSize=5000
local moonPos=1000
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

function moon:init(bg)
	self.parent=bg
	self.r=30
	self.rot=0
	self.body = love.graphics.newCanvas(self.r*2, self.r*2)
	self.aura=aura(_,true)

end


local color={}
color[-1]={255,255,155}
color[1]={10,10,50}


function moon:drawMoon()
	local r=self.r
	local phase=self.phase
	local angle=(phase/30)*Pi*2
	local rr=math.cos(angle)
	local side=math.sign(rr)	
	local half = math.sign(15.1-phase)
	love.graphics.setScissor( r+r*(half*side/2-0.5),0,r,2*r )
	love.graphics.setColor(color[-side])
	love.graphics.circle("fill", r, r, r)
	love.graphics.setColor(color[side])
	love.graphics.ellipse("fill", r, r, math.cos(angle)*r,r,r/2)
	love.graphics.setScissor()
	love.graphics.setScissor( r-r*(half*side/2+0.5),0,r,2*r )
	love.graphics.setColor(color[side])
	love.graphics.circle("fill", r, r, r)
	love.graphics.setScissor()
end

function moon:update()
	self.x,self.y=math.axisRot(0,moonPos,self.parent.rot)
	self.rot=self.parent.rot
	self.phase=self.parent.parent.timer.day
	love.graphics.setCanvas(self.body)
	self:drawMoon()
	love.graphics.setCanvas()
end

function moon:draw()

	love.graphics.setColor(255,250,155,46-math.abs(self.phase-15)*3)
	love.graphics.draw(self.aura, self.x+stageSize/2, self.y+stageSize/2, self.rot, self.r*10,self.r*10)
	love.graphics.setColor(255, 255,255)
	love.graphics.draw(self.body, self.x+stageSize/2, self.y+stageSize/2, self.rot, 1,1,self.r,self.r)
end


return moon
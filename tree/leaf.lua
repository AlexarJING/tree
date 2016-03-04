local leaf=Class("leaf")

function createLeaf5(segments)
	segments = segments or 50
	local vertices = {}
	table.insert(vertices, {0, 0})
	for i=0, segments do
		local angle = (i / segments) * math.pi * 2
		local x = math.cos(angle)/2
		local y = math.sin(angle)
		
		table.insert(vertices, {x, y})
		
	end
	return love.graphics.newMesh(vertices, "fan")

end

function createLeaf(segments)
	segments = segments or 50
	local vertices = {}
	table.insert(vertices, {0, 0})
	for i=0, segments do
		local angle = (i / segments) * math.pi * 2
		local x = math.cos(angle)
		local y = math.sin(angle)
		if x>0.5 then
			table.insert(vertices, {x-0.5, y})
		elseif x<-0.5 then
			table.insert(vertices, {x+0.5, y})
		end
	end
	return love.graphics.newMesh(vertices, "fan")

end


function createLeaf2(segments)
	segments = segments or 50
	local a=0.3
	local vertices = {}
	table.insert(vertices, {0, 0})
	for i=0, segments do
		local angle = (i / segments) * math.pi * 2
		local x=a*(2*math.cos(angle)-math.cos(2*angle))
		local y=a*(2*math.sin(angle)-math.sin(2*angle))
		table.insert(vertices, {x, y})
	end
	return love.graphics.newMesh(vertices, "fan")

end

function createLeaf3(segments)
	segments = segments or 50
	local a=0.05
	local vertices = {}
	table.insert(vertices, {0, 0})
	for i=0, segments do
		local angle = (i / segments) * math.pi * 2
		local x=16*a*(math.sin(angle))^3
		local y=a*(13*math.cos(angle)-5*math.cos(2*angle)-2*math.cos(3*angle)-math.cos(4*angle))
		table.insert(vertices, {x, y})
	end
	return love.graphics.newMesh(vertices, "fan")

end

function createLeaf4(segments)
	segments = segments or 10
	local vertices = {}
	table.insert(vertices, {0, 0})
	for i=0, segments do
		local angle = (i / segments) * math.pi * 2
		local x = math.cos(angle)
		local y = math.sin(angle)
		if i%2==0 then
			table.insert(vertices, {x, y})
		else 
			table.insert(vertices, {x/2, y/2})
		end
	end
	return love.graphics.newMesh(vertices, "fan")

end


function createLeaf6(segments)
	segments = segments or 30
	local vertices = {}
	table.insert(vertices, {0, 0})
	local a=1
	for i=0, segments do
		local angle = (i / segments) * math.pi * 2
		local x=a*(math.cos(angle))^3 
		local y=a*(math.sin(angle))^3
		table.insert(vertices, {x, y})
	end
	return love.graphics.newMesh(vertices, "fan")

end

function leaf:init(parent,rot)
	self.parent=parent
	self.pos=love.math.random()*self.parent.lenth/(self.parent.lenthLimit+self.parent.level)
	self.size=1
	self.angle=rot*Pi/2+rot*love.math.random()*Pi/4+self.parent.parent.angle
	self.state="grow"
	self.life=500
	self.color={155,255,155,100}
	self.sizeMax=10+love.math.random()*5
	self.mesh=createLeaf6()
	self:getPosition()
end


function leaf:getPosition()
	if self.state=="dead" then
		local micro=love.timer.getTime()-math.floor(love.timer.getTime())
		self.x=self.x+math.sin(micro*2*Pi)
		self.y=self.y+500/self.y
		local offx,offy=math.axisRot(0,self.size,self.angle)
		self.cx,self.cy=self.x+offx,self.y+offy
	else
		--local micro=love.timer.getTime()-math.floor(love.timer.getTime())
		--self.angle=self.angle+math.sin(micro*2*Pi)/100
		self.x=(self.parent.tx-self.parent.parent.tx)*self.pos+self.parent.parent.tx
		self.y=(self.parent.ty-self.parent.parent.ty)*self.pos+self.parent.parent.ty
		local offx,offy=math.axisRot(0,self.size,self.angle)
		self.cx,self.cy=self.x+offx,self.y+offy
	end

end



function leaf:update()
	self:getPosition()
	self.life=self.life-1
	if self.state=="grow" then
		if self.life<400 then self.state="grown" end
		self.size=self.size+1
		if self.size>self.sizeMax then self.size=self.sizeMax end
	elseif self.state=="grown" then
		if self.life<100 then self.state="dying" end
	elseif self.state=="dying" then
		
		if self.color[1]<250 and self.color[1]~=self.color[2] then
			self.color[1]=self.color[1]+ 1+love.math.random()
			if self.color[1]>self.color[2] then self.color[1]=self.color[2] end
		elseif self.color[1]>50 then
			self.color[1]=self.color[1]-2
			self.color[2]=self.color[2]-2
			self.color[3]=self.color[3]-2
		elseif self.color[1]<50 then
			if love.math.random()>1 then
				self.state="dead" 
			else
				table.removeItem(self.parent.leaf,self)
			end
		end
	else
		if self.y>self.parent.core.y then
			table.removeItem(self.parent.leaf,self)
		end
	end

end


function leaf:draw()
	love.graphics.setColor(self.color)
	love.graphics.draw(self.mesh, self.cx, self.cy, self.angle, self.size,self.size)
	love.graphics.setColor(255, 255, 255, 50)
	--love.graphics.setLineWidth(1)
	--love.graphics.line(self.cx, self.cy, self.x, self.y)
end

return leaf
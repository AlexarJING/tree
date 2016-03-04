local flower=Class("flower")

function createFlower(segments)
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



function flower:init(parent,rot)
	self.parent=parent
	self.pos=love.math.random()*self.parent.lenth/(self.parent.lenthLimit+self.parent.level)
	self.size=0.5
	self.angle=rot*Pi/2+rot*love.math.random()*Pi/4+self.parent.parent.angle
	self.state="grow"
	self.life=500
	self.color={255,155,200,100}
	self.sizeMax=5+love.math.random()*3
	self.mesh=createFlower()
	self:getPosition()
end


function flower:getPosition()
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



function flower:update()
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


function flower:draw()
	love.graphics.setColor(self.color)
	for i=1,6 do
		local angle=self.angle+(i-1)*2*Pi/6
		love.graphics.draw(self.mesh, self.cx, self.cy,angle, self.size,self.size)
	end
	--love.graphics.setColor(255, 255, 255, 50)
	--love.graphics.setLineWidth(1)
	--love.graphics.line(self.cx, self.cy, self.x, self.y)
end

return flower
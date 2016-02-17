local node=Class("node")

local WidthSpeed=0.5

function node:initialize(parent,limit,rot)
	self.parent=parent
	self.children={}
	self.level=1
	self.lenth=1
	self.width=1
	self.lenthSpeed = 0.2 + love.math.random()*0.2
	self.rot=rot and rot*Pi/4*love.math.random() or 0
	self.lenthLimit=limit or 30+20*love.math.random()
	if not self.parent then return end
	self.angle=self.parent.angle+self.rot-self.parent.angle/5
end

function node:getPosition()
	if self.parent then
		local offX,offY=math.axisRot(0,-self.lenth,self.parent.angle)
		self.x=self.parent.x+offX
		self.y=self.parent.y+offY
		local offX,offY=math.axisRot(-self.width/2,0,self.angle)
		self.lx=self.x+offX
		self.ly=self.y+offY
		local offX,offY=math.axisRot(self.width/2,0,self.angle)
		self.rx=self.x+offX
		self.ry=self.y+offY
	else
		self.lx=self.x-self.width/2
		self.ly=self.y
		self.rx=self.x+self.width/2
		self.ry=self.y
	end
end

function node:levelUp()
	local this=self
	while this.parent do
		if this.parent.level<=this.level then
			this.parent.level=this.parent.level+1
		end
		this=this.parent
	end

end


function node:branch()
	local rnd=love.math.random()
	if rnd>0.6 then
		table.insert(self.children,node(self,_,1))
		table.insert(self.children,node(self,_,-1))
	elseif rnd>0.5 then
		table.insert(self.children,node(self,_,-1))
	elseif rnd>0.4 then
		table.insert(self.children,node(self,_,1))
	else
		table.insert(self.children,node(self,_,0))
	end

	self:levelUp()
end


function node:grow()
	
	self:getPosition()
	

	self.lenth=self.lenth+self.lenthSpeed
	if self.lenth>self.lenthLimit+self.level then
		self.lenth=self.lenthLimit+self.level
	end

	self.width=self.width+WidthSpeed
	if self.width>self.level then
		self.width=self.level
	end

	if self.width==self.level and self.lenth==self.lenthLimit+self.level and not self.grown then
		self.grown=true
		self:branch()
	end

	for i,v in ipairs(self.children) do
		v:grow()
	end
end


function node:draw()
	if self.parent then
		love.graphics.setColor(255,255,255)
		love.graphics.polygon("fill",
			self.parent.lx,self.parent.ly,
			self.parent.rx,self.parent.ry,
			self.rx,self.ry,
			self.lx,self.ly
			)
		--love.graphics.line(self.x,self.y,self.parent.x,self.parent.y)
	else
		love.graphics.setColor(255,255,255)
		love.graphics.circle("fill", self.x,self.y,self.width/2)
	end
	for i,v in ipairs(self.children) do
		v:draw()
	end

end

return node
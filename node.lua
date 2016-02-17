local node=Class("node")

local WidthSpeed=0.01
local ApicalRate=1.7
function node:initialize(parent,rot)
	self.parent=parent
	self.children={}
	self.leaf={}
	self.level=1
	self.lenth=1
	self.width=1
	self.leafStep=30
	self.leafGrow=self.leafStep*love.math.random()
	
	
	self.rot=rot and rot*Pi*love.math.random() or 0
	self.lenthLimit=20


	if self.parent then 
		self.angle=self.parent.angle+self.rot-self.parent.angle/10
		self.core=self.parent.core
	else
		self.angle=0
		self.x=602
		self.y=700
		self.tx=self.x
		self.ty=self.y
		self.core=self
		self.topY=self.y
		--self.core.top=self
	end

	self:getPosition()
	if self.parent then
		if self.ty<self.core.topY then 
			self.core.topY=self.ty
			self.lenthSpeed=self.core.lenthSpeed
			if self.core.top then
				self.core.top.lenthSpeed=(self.core.lenthSpeed*
				(self.core.y-self.ty)/(self.core.y-self.core.topY)/ApicalRate)
			end
			self.core.top=self
		else
			self.lenthSpeed=(self.core.lenthSpeed*
				(self.core.y-self.ty)/(self.core.y-self.core.topY)/ApicalRate)
		end
		
	else
		self.lenthSpeed = 0.2
	end
	
end

function node:getPosition()
	if self.parent then
		local offX,offY=math.axisRot(0,-self.lenthLimit-self.level,self.angle)
		self.tx=self.parent.x+offX
		self.ty=self.parent.y+offY
		local offX,offY=math.axisRot(0,-self.lenth,self.angle)
		self.x=self.parent.x+offX
		self.y=self.parent.y+offY
		local offX,offY=math.axisRot(-self.width/2,0,self.angle)
		self.lx=self.x+offX
		self.ly=self.y+offY
		self.lx2=self.parent.x+offX
		self.ly2=self.parent.y+offY
		local offX,offY=math.axisRot(self.width/2,0,self.angle)
		self.rx=self.x+offX
		self.ry=self.y+offY
		self.rx2=self.parent.x+offX
		self.ry2=self.parent.y+offY
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

function node:setSpeed(nodeA,nodeB)
	if nodeA.ty<nodeB.ty then
		nodeA.lenthSpeed=nodeA.parent.lenthSpeed
		nodeB.lenthSpeed=nodeB.parent.lenthSpeed*0.5
	else
		nodeA.lenthSpeed=nodeA.parent.lenthSpeed*0.5
		nodeB.lenthSpeed=nodeB.parent.lenthSpeed
	end
end

function node:addBranch()
	local rnd=love.math.random()
	if rnd>0.6 then
		table.insert(self.children,node(self))	
	elseif rnd>0.3 then
		local nodeA=node(self,-0.1)
		local nodeB=node(self,0.4)
		table.insert(self.children,nodeA)
		table.insert(self.children,nodeB)		
	else
		local nodeA=node(self,0.1)
		local nodeB=node(self,-0.4)
		table.insert(self.children,nodeA)
		table.insert(self.children,nodeB)
	end
	self:levelUp()
end

function node:addLeaf()
	self.leafGrow=self.leafGrow-self.lenthSpeed
	if self.leafGrow<0 then
		self.leafGrow=self.leafStep
		local rnd=love.math.random()
		if rnd>0.7 then
			table.insert(self.leaf, Leaf(self,1))
			table.insert(self.leaf, Leaf(self,-1))
		elseif rnd>0.35 then
			table.insert(self.leaf, Leaf(self,-1))
		else
			table.insert(self.leaf, Leaf(self,1))
		end
	end

end


function node:grow()
	if self.level>=30 then return end
	self:getPosition()
	

	self.lenth=self.lenth+self.lenthSpeed
	if self.lenth>self.lenthLimit+self.level then
		self.lenth=self.lenthLimit+self.level
	end

	


	self.width=self.width+WidthSpeed
	if self.width>self.level then
		self.width=self.level
	end

	if (not self.grown) and self.parent then
		self:addLeaf()
	end

	if self.width==self.level and self.lenth==self.lenthLimit+self.level 
		and (not self.grown) and self.level>=#self.children then
		self.grown=true
		self:addBranch()
	end

	for i,v in ipairs(self.leaf) do
		v:update()
	end

	for i,v in ipairs(self.children) do
		v:grow()
	end


end


function node:draw()
	if self.parent then
		love.graphics.setColor(255,255,255)
		love.graphics.polygon("fill",
			self.lx2,self.ly2,
			self.rx2,self.ry2,
			self.rx,self.ry,
			self.lx,self.ly
			)
		love.graphics.circle("fill", self.x,self.y,self.width/2)
	else
		love.graphics.setColor(255,255,255)
		love.graphics.circle("fill", self.x,self.y,self.width/2)
	end
	for i,v in ipairs(self.leaf) do
		v:draw()
	end

	for i,v in ipairs(self.children) do
		v:draw()
	end

end

return node
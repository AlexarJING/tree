local node=Class("node")
local Leaf = require "tree/leaf"
local Flower = require "tree/flower"
local WidthSpeed=0.01
local ApicalRate=1.7
function node:init(parent,rot)
	self.parent=parent
	self.children={}
	self.leaf={}
	self.level=1
	self.lenth=1
	self.width=1
	self.leafStep=20
	self.leafGrow=self.leafStep*love.math.random()
	
	
	self.rot=rot and rot*Pi*love.math.random() or 0
	self.lenthLimit=20


	
	self.angle=self.parent.angle+self.rot-self.parent.angle/10
	self.core=self.parent.core
	

	self:getPosition()

	self:apicalEffect()
		
end

function node:apicalEffect()
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
end



function node:getPosition()
	
	if not self.dead then
		--local micro=love.timer.getTime()-math.floor(love.timer.getTime())
		--self.angle=self.angle+math.sin(micro*2*Pi)/1000
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
		self.y=self.y+self.y/500
		self.ly=self.ly+self.ly/500
		self.ry=self.ry+self.ry/500
		self.ly2=self.ly2+self.ly2/500
		self.ry2=self.ry2+self.ry2/500
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

function node:allDead()
	self.dead=true
	for i,v in ipairs(self.children) do
		v:allDead()
	end

	for i,v in ipairs(self.leaf) do
		v.state="dying"
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
	if self.core.level>=20 then return end
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

function node:removeBranch()
	for i,v in ipairs(self.children) do
		if self.level-v.level>12 then
			v:allDead()
		end
		if v.y>self.core.y then
			table.remove(self.children, i)
			return
		end
	end

end

function node:addLeaf()
	if #self.leaf>3 then return end
	self.leafGrow=self.leafGrow-self.lenthSpeed
	if self.leafGrow<0 then
		self.leafGrow=self.leafStep
		local rnd=love.math.random()
		rnd=-1

		if rnd>0.7 then
			table.insert(self.leaf, Leaf(self,1))
			table.insert(self.leaf, Leaf(self,-1))
		elseif rnd>0.35 then
			if self.core.level>1 then
				table.insert(self.leaf, Flower(self,-1))
			else
				table.insert(self.leaf, Leaf(self,-1))
			end
		elseif rnd>0 then
			if self.core.level>1 then
				table.insert(self.leaf, Flower(self,1))
			else
				table.insert(self.leaf, Leaf(self,1))
			end
		else
			table.insert(self.leaf, Flower(self,math.sign(0.5-lm.random())))
		end
	end

end


function node:update()
	
	self:getPosition()
	

	if not self.dead then

		self.lenth=self.lenth+self.lenthSpeed
		if self.lenth>self.lenthLimit+self.level then
			self.lenth=self.lenthLimit+self.level
		end

		


		self.width=self.width+WidthSpeed
		if self.width>self.level then
			self.width=self.level
		end

		if self.level==1 and self.parent then
			self:addLeaf()
		end

		if self.width==self.level and self.lenth==self.lenthLimit+self.level 
			and (not self.grown) and self.level>=#self.children then
			self.grown=true
			self:addBranch()
		end
	end
	self:removeBranch()
	for i,v in ipairs(self.leaf) do
		v:update()
	end

	for i,v in ipairs(self.children) do
		v:update()
	end


end


function node:draw()
	
	if self.dead then
		love.graphics.setColor(50,50,50)
	else
		love.graphics.setColor(255,255,255)
	end
	love.graphics.polygon("fill",
		self.lx2,self.ly2,
		self.rx2,self.ry2,
		self.rx,self.ry,
		self.lx,self.ly
		)
	love.graphics.circle("fill", self.x,self.y,self.width/2)
	
	for i,v in ipairs(self.leaf) do
		v:draw()
	end

	for i,v in ipairs(self.children) do
		v:draw()
	end

end

return node
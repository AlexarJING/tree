local node=Class("node")
local LenthLimit=50
local LenthSpeed=1
local WidthSpeed=0.5

function node:initialize(parent,limit,rot)
	self.parent=parent
	self.children={}
	self.level=1
	self.lenth=1
	self.width=1
	self.rot=rot or 0
	self.lenthLimit=limit or LenthLimit
	if not self.parent then return end
	self.angle=self.parent.angle+self.rot

	if math.abs(self.angle)>Pi/2 then
		self.angle=self.parent.angle+self.rot/4
	end
end

function node:getPosition()
	local offX,offY=math.axisRot(0,-self.parent.lenth,self.parent.angle)
	self.x=self.parent.x+offX
	self.y=self.parent.y+offY
end

function node:levelUp()
	local this=self
	while this.parent do
		if this.parent.width<=this.width then
			this.parent.level=this.parent.level+1	
		end
		this=this.parent
	end

end


function node:branch()
	local rnd=love.math.random()
	if rnd>0.8 or rnd<0.2 then
		table.insert(self.children,node(self,30+20*love.math.random(),Pi/4*love.math.random()))
		table.insert(self.children,node(self,30+20*love.math.random(),-Pi/4*love.math.random()))
	elseif rnd<0.4 then
		table.insert(self.children,node(self,30+20*love.math.random(),-Pi/4*love.math.random()))
	elseif rnd>0.6 then
		table.insert(self.children,node(self,30+20*love.math.random(),Pi/4*love.math.random()))
	else
		table.insert(self.children,node(self,30+20*love.math.random()))
	end

	self:levelUp()
end


function node:grow()
	if self.parent then
		self:getPosition()
	end

	self.lenth=self.lenth+LenthSpeed
	if self.lenth>self.lenthLimit then
		self.lenth=self.lenthLimit
	end

	self.width=self.width+WidthSpeed
	if self.width>self.level then
		self.width=self.level
	end

	if self.width==self.level and self.lenth==self.lenthLimit and not self.grown then
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
		love.graphics.setLineWidth(self.width)
		love.graphics.line(self.x,self.y,self.parent.x,self.parent.y)
	else
		love.graphics.setColor(100,255,100)
		love.graphics.circle("fill", self.x,self.y,self.lenth)
	end
	for i,v in ipairs(self.children) do
		v:draw()
	end

end

return node
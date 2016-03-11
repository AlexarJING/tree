local node = require "tree2/node"
local seed = Class("seed",node)

function seed:init()
	self.children={}
	self.leaf={}
	self.level=1
	

	self.lenth=1
	self.width=1
	

	self.leafStep=20
	self.leafGrow=self.leafStep*love.math.random()
	
	self.rot=0
	self.lenthLimit=20	
	self.angle=0
	
	self.x=2500
	self.y=2000
	
	self.tx=self.x
	self.ty=self.y
	
	self.core=self
	self.topY=self.y

	self:getPosition()

	self.lenthSpeed = 0.2
	
end

function seed:getPosition()
	self.lx=self.x-self.width/2
	self.ly=self.y
	self.rx=self.x+self.width/2
	self.ry=self.y
end

function seed:draw()
	--love.graphics.setColor(255,255,255)
	--love.graphics.circle("fill", self.x,self.y,self.lenth/2)
	
	for i,v in ipairs(self.leaf) do
		v:draw()
	end

	for i,v in ipairs(self.children) do
		v:draw()
	end

end
		

return seed
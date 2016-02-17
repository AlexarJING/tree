local leaf=Class("leaf")

function leaf:initialize(parent,rot)
	self.parent=parent
	self.pos=self.parent.lenth/(self.parent.lenthLimit+self.parent.level)
	self.size=1
	self.angle=rot*Pi/2+rot*love.math.random()*Pi/4+self.parent.parent.angle
	self.state="grow"
	self.life=500
	self.color={155,255,155,100}
	self.sizeMax=10+love.math.random()*5
end

function leaf:getPosition()
	self.x=(self.parent.tx-self.parent.parent.tx)*self.pos+self.parent.parent.tx
	self.y=(self.parent.ty-self.parent.parent.ty)*self.pos+self.parent.parent.ty
	local offx,offy=math.axisRot(0,self.size,self.angle)
	self.cx,self.cy=self.x+offx,self.y+offy

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
		if self.life<0 then self.state="dead" end
		if self.color[1]==self.color[2] then
			self.color[1]=self.color[1]-10
			self.color[2]=self.color[2]-10
			self.color[3]=self.color[3]-10
		else
			self.color[1]=self.color[1]+10
		end
	else
		if self.color[1]<0 then
			table.removeItem(self.parent.leaf,self)
		end
	end

end


function leaf:draw()
	love.graphics.setColor(self.color)
	love.graphics.ellipse( "fill", self.cx, self.cy, self.size/2,self.size,20 ,self.angle )
end

return leaf
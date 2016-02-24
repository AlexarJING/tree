local light=Class("lightning")
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

function light:init(rain)
	self.ox= ox or 1500+love.math.random()*1500
	self.oy= oy or 2500-1100
	self.tx= tx or self.ox
	self.ty= ty or 2100
	self:generate()
	self.aura=aura(_,true)
	self.life=40
	self.parent=rain
end

function light:generate()
	local generateLightning
	generateLightning=function(x1,y1,x2,y2,displace,curDetail,vert,index)
		vert= vert or {}
		if displace < curDetail then
			table.insert(vert, {x1,y1,x2,y2})
	 	else 
			local mid_x = (x2+x1)/2;
			local mid_y = (y2+y1)/2;
			mid_x = mid_x+(love.math.random()-.5)*displace;
			mid_y = mid_y+(love.math.random()-.5)*displace;
			generateLightning(x1,y1,mid_x,mid_y,displace/2,curDetail,vert);
			generateLightning(x2,y2,mid_x,mid_y,displace/2,curDetail,vert);
	 	end
 	end
 	self.vert={}
 	generateLightning(self.ox,self.oy,self.tx,self.ty,300,10,self.vert)
end


function light:update()
	self.life=self.life-1
	if self.life<0 then table.removeItem(self.parent, self) end
end


function light:draw()
	if self.life<0 then return end
	for i,v in ipairs(self.vert) do
		for i=7,2,-1 do
			love.graphics.setLineWidth(i)
			love.graphics.setColor(300-i*50, 300-i*50, 255,(self.life/300)*255/i)
			love.graphics.line(v)
		end
	end
	love.graphics.setColor(255, 255, 255, (self.life/300)*255)
	love.graphics.draw(self.aura, self.ox, self.oy,0,200, 200)
	love.graphics.setColor(255, 255, 255, (self.life/300)*255)
	love.graphics.draw(self.aura, self.ox, (self.oy+self.ty)/2,0,500, 500)
end

return light

local Cloud=Class("cloud")
local stageSize=5000

local function CreateCircle(segments,alpha)
	segments = segments or 10
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

function Cloud:init(bg,rx,ry,gray)
	self.parent=bg
	self.parts={}
	self.height=1100
	self.thickness=100
	self.rx = rx or 100
	self.ry = ry or 50
	self.gray = gray or 255
	self.speed = speed or 0.2
	self.body  = love.graphics.newCanvas(self.rx*4,self.ry*4)
	self:create()
	self.ball=CreateCircle()
end

function Cloud:create()
	for i=1,self.thickness do
		local part={
			x=(0.5-love.math.random())*self.rx*2,
			y=(0.5-love.math.random())*self.ry*2,
			r=(1+love.math.random())*self.rx/5,
			vx=(0.5-love.math.random())*self.speed,
			vy=(0.5-love.math.random())*self.speed,
			vc=(0.5-love.math.random())*self.speed,
			gray=(0.5-love.math.random())*100+self.gray
		}
		table.insert(self.parts, part)
	end

end

function Cloud:reset()


end


function Cloud:update(dt)
	--self.rot=self.parent.rot
	--self.x,self.y=math.axisRot(0,self.height,self.parent.rot+self.pos)
	love.graphics.setCanvas(self.body)
	
	love.graphics.clear()
	for i,v in ipairs(self.parts) do	
		v.x=v.x+v.vx
		if v.x>self.rx then
 			v.vx=-math.abs(v.vx)
 			v.x=self.rx
		elseif v.x<-self.rx then
			v.vx=math.abs(v.vx)
			v.x=-self.rx
		end
		v.y=v.y+v.vy
		if v.y>self.ry then
 			v.vy=-math.abs(v.vy)
 			v.y=self.ry
		elseif v.y<-self.ry then
			v.vy=math.abs(v.vy)
			v.y=-self.ry
		end
		

		local alpha = 40-math.abs(v.y)+self.rx*40/math.abs(v.x)
		if alpha<0 then alpha=0 end;if alpha>40 then alpha=40 end
		--love.graphics.setBlendMode("add")
		love.graphics.setColor(self.gray,self.gray,self.gray,45)
		love.graphics.draw(self.ball, 2*self.rx+v.x,2*self.ry+v.y+math.abs(v.x)/10,0,v.r,v.r)
	end
	love.graphics.setCanvas()
end

 
function Cloud:draw()
	love.graphics.setColor(255, 255,255)
	love.graphics.draw(self.body, stageSize/2, -self.height+stageSize/2,self.rot,1,1,self.rx*2,self.ry*2)
end


return Cloud
local Cloud=Class("cloud")
local stageSize=5000

function Cloud:init(bg,rot,rx,ry,gray)
	self.parent=bg
	self.parts={}
	self.height=1000
	self.thickness=2000
	self.rx = rx or 1000
	self.ry = ry or 100
	self.gray = gray or 100
	self.speed = speed or 0.1
	self.body  = love.graphics.newCanvas(self.rx*4,self.ry*4)
	self.pos= rot or 0
	self:create()
end

function Cloud:create()
	for i=1,self.thickness do
		local part={
			x=(0.5-love.math.random())*self.rx*2,
			y=(0.5-love.math.random())*self.ry*2,
			r=(1+love.math.random())*self.ry/2,
			vx=(0.5-love.math.random())*self.speed,
			vy=(0.5-love.math.random())*self.speed,
			vr=(0.5-love.math.random())*self.speed,
			vc=(0.5-love.math.random())*self.speed,
			gray=(0.5-love.math.random())*100+self.gray
		}
		table.insert(self.parts, part)
	end

end


function Cloud:update(dt)
	self.rot=self.parent.rot
	self.x,self.y=math.axisRot(0,self.height,self.parent.rot+self.pos)
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
		v.r=v.r+v.vr
		if v.r>self.ry then 
			v.vr=-math.abs(v.vr) 
			v.r = self.ry
		elseif v.r<self.ry/2 then
			v.vr=math.abs(v.vr)
			v.r = self.ry/2
		end
		if v.r>self.ry then print(v.r,v.vr,self.ry) end
		--v.gray=v.gray+v.vc
		if v.gray>self.gray+100 or v.gray>255 then 
			if v.gray>255 then
				v.gray=255
			else
				v.gray=self.gray+100
			end
			v.vc=-v.vc 
		elseif v.gray<self.gray-100 or v.gray<0 then 
			if v.gray<0 then
				v.gray=0
			else
				v.gray=self.gray-100
			end
			v.vc=-v.vc 
		end
		love.graphics.setColor(self.gray,self.gray,self.gray,10)
		love.graphics.circle("fill", 2*self.rx+v.x,2*self.ry+v.y/(math.abs(v.x)/self.rx+1)-math.abs(v.x)/20,v.r)
	end
	love.graphics.setCanvas()
end

 
function Cloud:draw()
	love.graphics.setColor(255, 255,255)
	--love.graphics.circle("fill", self.x+stageSize/2, self.y+stageSize/2,10)
	love.graphics.print("123",self.x+stageSize/2, self.y+stageSize/2, self.rot, 20,20,self.rx,self.ry)
	love.graphics.draw(self.body, self.x+stageSize/2, self.y+stageSize/2,self.rot,1,1,self.rx*2,self.ry*2)

end


return Cloud
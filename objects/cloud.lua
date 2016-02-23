local Cloud=Class("cloud")
local stageSize=5000

function Cloud:init(bg,rot,rx,ry,gray)
	self.parent=bg
	self.parts={}
	self.height=900
	self.thickness=200
	self.rx = rx or 500
	self.ry = ry or 100
	self.gray = gray or 255
	self.speed = speed or 0.5
	self.body  = love.graphics.newCanvas(self.rx*3,self.ry*3)
	self.pos= rot or 0
	self:create()
end

function Cloud:create()
	for i=1,self.thickness do
		local part={
			x=(0.5-love.math.random())*self.rx,
			y=(0.5-love.math.random())*self.ry,
			r=(0.5+0.5*love.math.random())*self.ry,
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
		if v.x>self.rx or v.x<-self.rx then v.vx=-v.vx end
		v.y=v.y+v.vy
		if v.y>self.ry or v.y<-self.ry then v.vy=-v.vy end
		v.r=v.r+v.vr
		if v.r<self.ry/2 or v.r>self.ry then v.vr=-v.vr end
		v.gray=v.gray+v.vc
		if v.gray>self.gray+100 or v.gray<self.gray-100 or v.gray>255 or v.gray<0 then v.vr=-v.vr end
		love.graphics.setColor(self.gray,self.gray,self.gray,50)
		love.graphics.circle("fill", 1.5*self.rx+v.x,1.5*self.ry+v.y,v.r)
	end
	love.graphics.setCanvas()
end

 
function Cloud:draw()
	love.graphics.setColor(255, 255,255)
	--love.graphics.circle("fill", self.x+stageSize/2, self.y+stageSize/2,10)
	love.graphics.print("123",self.x+stageSize/2, self.y+stageSize/2, self.rot, 20,20,self.rx,self.ry)
	love.graphics.draw(self.body, self.x+stageSize/2, self.y+stageSize/2,self.rot,1,1,self.rx*1.5,self.ry*1.5)

end


return Cloud
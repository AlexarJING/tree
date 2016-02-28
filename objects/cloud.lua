local Cloud=Class("cloud")
local stageSize=5000

local function CreateCircle(segments,alpha)
	segments = segments or 10
	alpha = alpha and 0 or 255
	local vertices = {}
	table.insert(vertices, {0, 0,100})
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
	self.height=1150
	self.thickness=500
	self.rx = rx or 1000
	self.ry = ry or 150
	self.gray = gray or 100
	self.speed = speed or 0.2
	self.body  = love.graphics.newCanvas(self.rx*4,self.ry*4)
	self:create()
	self.ball=CreateCircle(20,true)
end

function Cloud:create()
	for i=1,self.thickness do
		local gray=(0.5-love.math.random())*200+self.gray
		if gray>255 then gray=255 end
		if gray<0 then gray=0 end
		local part={
			x=(0.5-love.math.random())*self.rx*2,
			y=(0.5-love.math.random())*self.ry*2,
			r=(1+love.math.random())*self.ry/3,
			vx=(0.5-love.math.random())*self.speed,
			vy=(0.5-love.math.random())*self.speed,
			vc=(0.5-love.math.random())*self.speed,
			gray=gray
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
		

		love.graphics.setColor(self.gray,self.gray,self.gray,200)
		love.graphics.draw(self.ball, 2*self.rx+v.x,2*self.ry+v.y+math.abs(v.x)/10,0,v.r,v.r)
	end
	love.graphics.setCanvas()
end

 
function Cloud:draw()
	love.graphics.setColor(255, 255,255)
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
		
		love.graphics.setColor(self.gray,self.gray,self.gray,100)
		love.graphics.draw(self.ball, v.x+stageSize/2,stageSize/2-self.height+v.y+math.abs(v.x)/10,0,v.r,v.r)
	end
end


return Cloud
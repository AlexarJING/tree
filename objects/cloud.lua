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
	self.height=1200
	self.thickness=400
	self.rx = rx or 1000
	self.ry = ry or 150
	self.gray = gray or 250
	self.speed = speed or 0.3
	self:create()
	self.ball=CreateCircle(20,true)
end

function Cloud:insert()
	local gray=(0.5-love.math.random())*200+self.gray
		if gray>255 then gray=255 end
		if gray<0 then gray=0 end
		local part={
			x=(0.5-love.math.random())*self.rx*2,
			y=(0.5-love.math.random())*self.ry*2,
			r=(2+love.math.random())*self.ry/3,
			vx=self:getRandomV(),
			vy=self:getRandomV(),
			gray=gray,
			state=imm  --0 for standard 1 for increase -1 for decrearse
		}
	table.insert(self.parts, part)
end

function Cloud:remove()
	for i,v in ipairs(self.parts) do
		if v.state==0 then
			v.state=-1
		end
	end
end

function Cloud:create()
	for i=1,self.thickness do
		local gray=(0.5-love.math.random())*50+self.gray
		if gray>255 then gray=255 end
		if gray<0 then gray=0 end
		local part={
			x=(0.5-love.math.random())*self.rx*2,
			y=(0.5-love.math.random())*self.ry*2,
			r=(2+love.math.random())*self.ry/3,
			vx=self:getRandomV()*math.sign(0.5-love.math.random()),
			vy=self:getRandomV()*math.sign(0.5-love.math.random()),
			gray=gray,
			alpha=1,
		}
		table.insert(self.parts, part)
	end
end

function Cloud:reset(index)
	local alpha,gray
	if index>0.5 then
		alpha=1
		gray=255-(index-0.5)*500
	else
		alpha=((index*3.3)^2)/10
		gray=255
	end
	for i,v in ipairs(self.parts) do	
		v.alpha=alpha
		v.gray=v.gray+(gray-v.gray)/5
	end
end

function Cloud:getRandomV()
	local wind=love.math.random()*self.speed*(math.abs(game.wind)+1)*math.sign(game.wind+0.001)
	return love.math.random()*self.speed*(math.abs(game.wind)+1)*math.sign(game.wind+0.001)
end


function Cloud:update(dt)
	for i,v in ipairs(self.parts) do	
		v.x=v.x+v.vx
		if v.x>self.rx then
 			v.vx=-math.abs(self:getRandomV())
 			v.x=self.rx
		elseif v.x<-self.rx then
			v.vx=math.abs(self:getRandomV())
			v.x=-self.rx
		end
		v.y=v.y+v.vy
		if v.y>self.ry then
 			v.vy=-math.abs(self:getRandomV())
 			v.y=self.ry
		elseif v.y<-self.ry then
			v.vy=math.abs(self:getRandomV())
			v.y=-self.ry
		end
	end
end

 
function Cloud:draw()

	for i,v in ipairs(self.parts) do	
		love.graphics.setColor(v.gray*game.brightness,v.gray*game.brightness,v.gray*game.brightness,100*v.alpha)
		love.graphics.draw(self.ball, v.x+stageSize/2,stageSize/2-self.height+v.y+math.abs(v.x)/10,0,v.r,v.r)
	end
end


return Cloud
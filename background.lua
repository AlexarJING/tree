local bg={}

bg.canvas = love.graphics.newCanvas(3000,3000)

bg.sun={}

local function CreateCircle(segments,alpha)
	segments = segments or 40
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
 

bg.sun.ball={
	shape=CreateCircle(),
	x=1500,
	y=400,
	r=30
}

bg.sun.aura={
	shape=CreateCircle(_,true),
	x=1500,
	y=400,
	r=2000
}

bg.moon={}

bg.moon.ball={
	shape=CreateCircle(),
	x=1500,
	y=2600,
	r=20
}

bg.moon.aura={
	shape=CreateCircle(_,true),
	x=1500,
	y=2600,
	r=500
}

bg.atmos=love.graphics.newMesh(
	{	
		{1500,1500,0,0,50,50,100},
		{0,0,0,0,100,215,255},
		{3000,0,0,0,100,215,255},
		{3000,1500,0,0,200,50,50},
		{3000,3000,0,0,0,0,0},
		{0,3000,0,0,0,0,0},
		{0,1500,0,0,200,50,50},
		{0,0,0,0,100,215,255},
	}	
		)



bg.cloud={
	parts={},
	x=1550,
	y=420,
	rx=80,
	ry=20,
	rot=0
}

for i=1,200 do
	local part={
		x=bg.cloud.x+(0.5-love.math.random())*bg.cloud.rx,
		y=bg.cloud.y+(0.5-love.math.random())*bg.cloud.ry,
		r=(0.5-love.math.random())*bg.cloud.rx/2,
		vx=love.math.random()*0.1,
		vy=love.math.random()*0.1,
		vr=(0.5-love.math.random())*0.1
	}
	table.insert(bg.cloud.parts, part)
end


local function drawCloud()

	for i,v in ipairs(bg.cloud.parts) do
		
		v.x=v.x+v.vx
		if v.x>bg.cloud.x+bg.cloud.rx or v.x<bg.cloud.x-bg.cloud.rx then v.vx=-v.vx end
		v.y=v.y+v.vy
		if v.y>bg.cloud.y+bg.cloud.ry or v.y<bg.cloud.y-bg.cloud.ry then v.vy=-v.vy end
		v.r=v.r+v.vr
		if v.r>bg.cloud.ry or v.r<3*bg.cloud.ry/4 then v.vr=-v.vr end
		love.graphics.setColor(150+i*2,150+i*2,150+i*2,200)
		love.graphics.circle("fill", v.x,v.y,v.r)
	end

end


love.graphics.setCanvas(bg.canvas)
	
	--love.graphics.setColor(10,10,20,50)
	--love.graphics.circle("fill", 1200, 1200, 1200)

	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(bg.atmos)
	
	for i= 1,300 do
		local rad= love.math.random()*2*Pi
		local x= (love.math.random()*750+750)*math.sin(rad)
		local y= (love.math.random()*750+750)*math.abs(math.cos(rad))
		love.graphics.setColor(255, 255, 255,100+155*love.math.random())	
		love.graphics.points(x+1500, y+1500)
	end
	
	love.graphics.setColor(255,255,215,50)
	love.graphics.draw(bg.sun.aura.shape,bg.sun.aura.x,bg.sun.aura.y,0,bg.sun.aura.r,bg.sun.aura.r)

	love.graphics.setColor(255,255,200)
	love.graphics.draw(bg.sun.ball.shape,bg.sun.ball.x,bg.sun.ball.y,0,bg.sun.ball.r,bg.sun.ball.r)

	love.graphics.setColor(255,255,255,50)
	love.graphics.draw(bg.moon.aura.shape,bg.moon.aura.x,bg.moon.aura.y,0,bg.moon.aura.r,bg.moon.aura.r)

	love.graphics.setColor(255,255,100)
	love.graphics.draw(bg.moon.ball.shape,bg.moon.ball.x,bg.moon.ball.y,0,bg.moon.ball.r,bg.moon.ball.r)

	love.graphics.setColor(255,255,255)
	love.graphics.circle("fill", 1500,1500,700)
love.graphics.setCanvas()

bg.rot=0



function bg:draw()
	
	self.rot=self.rot+ love.timer.getDelta()*Pi/10
	love.graphics.setColor(255,255,255)
	love.graphics.draw(bg.canvas,1500,1500,self.rot,1,1,1500,1500)
	--drawCloud()
end
return bg
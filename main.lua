Class = require "middleclass"
require "util"
Tween = require "tween"
Node = require "node"
Leaf = require "leaf"
function love.load()
	tree=Node()
	bg= require("background")
end

function love.update(dt)
	tree:grow(dt)
end




function love.draw()
	love.graphics.translate( -1320, -300 )
	bg:draw()
	
	tree:draw()
	phase=phase and phase+0.05 or 0
	if phase>27 then phase=0 end
	drawMoon(200,200,100,phase)
end

local color={}
color[-1]={255,255,255}
color[1]={10,10,250}

function drawMoon(x,y,r,phase)
	local angle=(phase/28)*Pi*2
	local rr=math.cos(angle)
	local side=math.sign(rr)	
	local half = math.sign(14.1-phase)
	love.graphics.setScissor( x+r*(half*side/2-0.5),y-r,r,2*r )
	love.graphics.setColor(color[-side])
	love.graphics.circle("fill", x, y, r)
	love.graphics.setColor(color[side])
	love.graphics.ellipse("fill", x, y, math.cos(angle)*r,r,r/2)
	love.graphics.setScissor()
	love.graphics.setScissor( x-r*(half*side/2+0.5),y-r,r,2*r )
	love.graphics.setColor(color[side])
	love.graphics.circle("fill", x, y, r)
	love.graphics.setScissor()

end







--[[

local vert={
		{602,768,0,0,255,100,100},
		{0,768,0,0,100,100,255},
		{0,0,0,0,100,100,255},
		{1204,0,0,0,100,100,255},
		{1204,768,0,0,100,100,255},
	}
	mesh = love.graphics.newMesh(vert)
	local vert2={
		{900,300,0,0,255,200,100},
		{1204,0,0,0,150,150,255},
		{1204,768,0,0,150,150,255},
		{0,768,0,0,150,150,255},
		{0,0,0,0,150,150,255},
		{1204,0,0,0,150,150,255},
	}
	mesh2 = love.graphics.newMesh(vert2)
	stars={}
	for i=1,100 do
		table.insert(stars, {love.math.random()*1204,love.math.random()*768})
	end

local function bg()
	love.graphics.setColor(255, 255,255)
	love.graphics.circle("fill", 602, 1600, 900)
end

	love.graphics.setColor(100, 100,100)
	--love.graphics.setColor(255, 255,255)
	love.graphics.draw(mesh)
	love.graphics.setColor(255,255,255)
	--love.graphics.circle("fill", 900,300,50)
	
		for i,v in ipairs(stars) do
		love.graphics.points(unpack(v))
	end

	bg()
]]
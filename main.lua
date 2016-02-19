print(love.graphics.getDimensions( ))
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
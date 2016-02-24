Class = require "libs/middleclass"
require "libs/util"
Tween = require "libs/tween"
Node = require "tree/node"
Leaf = require "tree/leaf"
Gamestate = require "libs/gamestate"
Resolution={
	x=360,
	y=600	
}


--背景层不变化scale,前景层可以缩放 同时，限定在树任何部分可见的范围内

function love.load()
	love.graphics.setBackgroundColor(0,0,50)
	state={}
	state.game=require("scene/game")
	Gamestate.registerEvents()
	Gamestate.switch(state.game)
end

function love.update(dt)
	love.window.setTitle(love.timer.getFPS())
end




function love.draw()

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
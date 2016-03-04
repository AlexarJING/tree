local bg=Class("bg")
local Sky = require "objects/sky3"
local Sun = require "objects/sun"
local Moon = require "objects/moon"
local Star = require "objects/star"

function bg:init(scene)
	self.child={}
	self.star=Star(self)
	self.sky =Sky(self)
	self.sun = Sun(self)
	self.moon = Moon(self)
	--table.insert(self.child,self.sky)
	table.insert(self.child,self.star)
	
	--table.insert(self.child,self.sun)
	--table.insert(self.child,self.moon)

	
	self.rot=0
end




function bg:update(dt)
	self.pos= game.timer.hour+game.timer.minut/60
	self.rot = self.pos*Pi/12+Pi
	for i,v in ipairs(self.child) do
		v:update()
	end
end


function bg:draw()
	for i,v in ipairs(self.child) do
		v:draw()
	end
end


return bg
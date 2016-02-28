local bg=Class("bg")
local Sky = require "objects/sky3"
local Sun = require "objects/sun"
local Moon = require "objects/moon"
local Star = require "objects/star"

function bg:init(scene)
	self.child={}
	--table.insert(self.child,Star(self))
	table.insert(self.child,Sky(self))
	--table.insert(self.child,Sun(self))
	--table.insert(self.child,Moon(self))

	self.brightness=0.5
	self.colorful=0.15
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
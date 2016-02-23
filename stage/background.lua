local bg=Class("bg")
local Sky = require "objects/sky"
local Sun = require "objects/sun"
local Moon = require "objects/moon"
local Cloud = require "objects/cloud"

function bg:init(scene)
	self.parent=scene
	self.child={}
	table.insert(self.child,Sky(self))
	table.insert(self.child,Sun(self))
	table.insert(self.child,Moon(self))
	table.insert(self.child,Cloud(self))
	self.rot=0
end




function bg:update(dt)
	self.rot = (self.parent.timer.hour+self.parent.timer.minut/60)*Pi/12+Pi
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
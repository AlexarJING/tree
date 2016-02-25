local fg=Class("fg")
local Ground= require "objects/ground"
local Tree = require "tree/node"
local Cloud = require "objects/cloud"
local Rain = require "objects/rain"
local Snow= require "objects/snow"


function fg:init()
	self.parent=scene
	self.child={}
	--table.insert(self.child,Cloud(self))
	--table.insert(self.child,Rain(self))
	--table.insert(self.child,Lightning(self))
	--table.insert(self.child,Snow(self))
	table.insert(self.child,Ground(self))
	table.insert(self.child,Tree())
end


function fg:update()
	for i,v in ipairs(self.child) do
		v:update()
	end

end


function fg:draw()
	for i,v in ipairs(self.child) do
		v:draw()
	end
end


return fg
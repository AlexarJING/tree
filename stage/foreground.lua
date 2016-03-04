local fg=Class("fg")
local Ground= require "objects/ground"
local Tree = require "tree/seed"
local Cloud = require "objects/cloud"
local Rain = require "objects/rain"



function fg:init()

	self.child={}
	self.rain=Rain(self)
	--table.insert(self.child,self.rain)
	self.cloud=Cloud(self)
	--table.insert(self.child,self.cloud)
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
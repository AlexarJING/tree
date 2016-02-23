local fg=Class("fg")
local Ground= require "objects/ground"
local Tree = require "tree/node"

function fg:init()
	self.parent=scene
	self.child={}
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
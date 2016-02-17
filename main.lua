Class = require "middleclass"
require "util"
Tween = require "tween"
Node = require "node"
Leaf = require "leaf"
function love.load()
	tree=Node()
	
end

function love.update(dt)
	tree:grow(dt)
end

function love.draw()
	tree:draw()
end
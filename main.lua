Class = require "middleclass"
require "util"
Tween = require "tween"
Node = require "node"

function love.load()
	tree=Node()
	tree.x=602
	tree.y=600
	tree.angle=0
end

function love.update(dt)
	tree:grow(dt)
end

function love.draw()
	tree:draw()
end
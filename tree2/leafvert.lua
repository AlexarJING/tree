local leafVert={}

function createLeaf()
	segments = segments or 50
	alpha = alpha and 0 or 255
	local vertices = {}
	table.insert(vertices, {0, 0})
	for i=0, segments do
		local angle = (i / segments) * math.pi * 2
		local x = math.cos(angle)
		local y = math.sin(angle)
		if x>0.5 then
			table.insert(vertices, {x-0.5, y})
		elseif x<-0.5 then
			table.insert(vertices, {x+0.5, y})
		end
	end
	return love.graphics.newMesh(vertices, "fan")

end
local Shape={}

function Shape.box(w,h)
	return {{0,0},{w,0},{w,h},{0,h}}
end



function Shape.regular(seg)
	seg=seg or 30
	local vert={}
	table.insert(vert,{0,0})
	local step = 2 * math.pi / seg
	for i = step/2 , 2 * math.pi + step/2 , step do
		table.insert(vert, {math.cos(i),math.sin(i)})
	end
	return vert
end

function Shape.circle(seg)
	seg=seg or 30
	local vert={}
	table.insert(vert,{0,0})
	for i = 0 , seg   do
		local r= i * 2 * math.pi / seg
		table.insert(vert, {math.cos(r),math.sin(r)})
	end
	return vert
end

function Shape.ellipse(rx,ry,seg)
	seg=seg or 30
	local sum= rx+ry
	local vert={}
	table.insert(vert,{0,0})
	for i = 0 , seg   do
		local r= i * 2 * math.pi / seg
		table.insert(vert, {math.cos(r)*rx/sum,math.sin(r)*ry/sum})
	end
	return vert
end


function Shape.new(shapeType,...)
	local mesh=love.graphics.newMesh(Shape[shapeType](...))
	return mesh
end


love.graphics.newShape=Shape.new
return Shape
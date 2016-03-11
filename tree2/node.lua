local node=Class("node")

local function toSky(rot,parent_angle,rate)
	local parent_angle=math.unitAngle(parent_angle+Pi)-Pi
	local angle=math.unitAngle(rot+parent_angle+Pi)-Pi
	

	if rate<0 then
		if rate<-1 then rate=-1 end
		return angle-(Pi-math.abs(angle))*math.sign(angle)*rate
	else
		return angle*0.6-parent_angle
	end
end

function toAngle(from,to,step)
	local dt=math.unitAngle(to)-math.unitAngle(from)
	
	if dt>Pi then
		dt=(dt-2*Pi)*(1-step)
	elseif dt<-Pi then
		dt=(dt+2*Pi)*(1-step)
	else
		dt=dt*(1-step)
	end

	return dt
end

local function getAngle(node,dir)
	local rot=love.math.randomNormal( 0.3, node.tree.subBranchAngle )*dir
	local angle= node.angle+rot
	--rot=toSky(rot,node.angle,node.tree.subBranchToSkyRate)
	local angle2=toAngle(angle,0,0.3)
	rot=angle2-node.angle
	return rot
end
--dichotomy 二叉分支 --dichotomy_f 伪二叉 sympodial合轴分枝 Spindle 主轴分支 

function node.static.dichotomySprout(self,isMain)
	
	if isMain then
		table.insert(self.children, self.tree.Node(self,getAngle(self,self.branchDirection),true))
	else
		table.insert(self.children, self.tree.Node(self,getAngle(self,-self.branchDirection),true))
	end
	
end

function node.static.spindleSprout(self,isMain)
	if isMain then
		table.insert(self.children, self.tree.Node(self,getAngle(self,0),isMain))
	else
		table.insert(self.children, self.tree.Node(self,getAngle(self,self.branchDirection),isMain))
	end
end

function node:init(parent,rot,isMain)

	self.tree=parent.tree
	self.tree.nodeCount=self.tree.nodeCount+1
	self.parent=parent
	
	self.level=0 --节点等级，末端为1，每当节点发芽，其连续父节点等级+1
	self.lenth=1 --节点长宽，其生长速度受制于树的节点长宽比
	self.width=1

	
	self.rot= rot or 0

	--self.softAngle=self.parent.angle+math.sign(Pi-self.hardAngle)*self.tree.softness*Pi

	self.isMain=isMain
	if isMain then
		self.power = self.parent.power
	else
		self.power = self.parent.power*0.5
	end
	

	self.matureLenth=30 --节点成熟长度，当节点成熟,且时令合适时，会发芽
	self.topBranch=false --发顶芽
	self.subBranch=false  --发侧芽

	self.branchDirection=-self.parent.branchDirection --与上一次相反

	self.children={}
	self:levelUp()
	self.sprout=node[self.tree.subBranchType.."Sprout"]

end



function node:levelUp()
	self.level=self.level+1
	local this=self 
	while this.parent and this.level==this.parent.level do --连续level则递增
		this=this.parent
		this.level=this.level+1
	end
	self.maxLevel=this.level
end

function node:getResource()


end

function node:grow()


	if self.isMain then
		self.power = self.parent.power
	else
		self.power = self.parent.power*0.5
	end

	self.speed=0.7^(self.level-1)*self.power
	
	self.lenth=self.lenth+ self.speed
	self.width=self.level
	if self.lenth>self.matureLenth and not self.topBranch then
		self.topBranch=true
		self:sprout(true)
		self:levelUp()
	end

	if self.level>self.tree.apicalLevel and not self.subBranch then
		self.subBranch=true
		self:sprout()
	end
end


function node:getPosition()
	self.angle=math.unitAngle(self.parent.angle+self.rot)

	local offX,offY=math.axisRot(0,-self.lenth,self.angle)
	self.x=self.parent.x+offX
	self.y=self.parent.y+offY
--[[	local offX,offY=math.axisRot(-self.width/2,0,self.angle)
	self.lx=self.x+offX
	self.ly=self.y+offY
	self.lx2=self.parent.x+offX
	self.ly2=self.parent.y+offY
	local offX,offY=math.axisRot(self.width/2,0,self.angle)
	self.rx=self.x+offX
	self.ry=self.y+offY
	self.rx2=self.parent.x+offX
	self.ry2=self.parent.y+offY]]
	
end




function node:update()
	self:grow()
	self:getPosition()

	for i,v in ipairs(self.children) do
		v:update()
	end


end


function node:draw()
	
	if self.dead then
		love.graphics.setColor(50,50,50)
	else
		love.graphics.setColor(255,255,255)
	end
	
	love.graphics.setLineWidth(self.level)
	love.graphics.line(self.x, self.y, self.parent.x, self.parent.y)
--[[
	love.graphics.polygon("fill",
		self.lx2,self.ly2,
		self.rx2,self.ry2,
		self.rx,self.ry,
		self.lx,self.ly
		)]]
	love.graphics.circle("fill", self.x,self.y,self.width/2)
	

	for i,v in ipairs(self.children) do
		v:draw()
	end

end

return node
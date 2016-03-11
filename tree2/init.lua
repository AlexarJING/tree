local tree=Class("tree")

tree.Node= require "tree2/node"
tree.Leaf= require "tree2/leaf"
tree.Flower= require "tree2/flower"



function tree:init()
	self.x=2500
	self.y=2000
	self.angle=0

	self.tree=self
	self.growSpeed=1
	self.power=1

	self.level=2

	self.branchDirection=1 --作为互生的方向控制

	self.nodeCount=0
	self.nodeLenthLimit=20 --树节点长度，节点越短分支可能越多，长节点的例如竹子，短节点的例如盆景树
	self.nodeLWRatio=5 --树节点长宽比， 越大树木越修长，越短树木越结实

	self.subLeafType="overlapping" --overlapping 互生 pair 对生 wheel 轮生 multy 簇生
	self.subBranchType="dichotomy" --dichotomy 二叉分支 --dichotomy_f 伪二叉 sympodial合轴分枝 Spindle 主轴分支  diff多岐分支
	self.subBranchAngle=Pi/3 --+-45deg 20
	self.subBranchToSkyRate=0.1  --为0时 无方向，为1时完全向上， 为-1时完全向下
	self.apicalLevel=1
	self.softness=0.3
	self.root=self:Node(0,1) --rot,growRate


end

function tree:update(dt)
	self.power=0.9^self.level
	--self.subBranchToSkyRate=1-self.level/8
	--self.apicalLevel=8-self.level/5
	self.root:update(dt)
end

function tree:draw()
	self.root:draw()
end




return tree
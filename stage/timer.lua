local timer = Class("timer")


function timer:init()
	self.year=0
	self.month =8
	self.day=1
	self.hour=0
	self.minut=0
	self.hourTotal=0
	self.multiply=1
	self.debug=true
	self.nextCheck=0
	self:getSeason()
end

function timer:getSeason()
	if self.month<3 then
		self.season="冬季"
	elseif self.month<6 then
		self.season="春季"
	elseif self.month<9 then
		self.season="夏季"
	elseif self.month<12 then
		self.season="秋季"
	else
		self.season="冬季"
	end

end






function timer:update(dt)
	self.minut=self.minut+dt*self.multiply
	if self.minut>=60 then
		self.hour = self.hour + math.floor(self.minut / 60)
		self.minut = self.minut % 60
		if self.hour>24 then
			self.day = self.day + math.floor(self.hour / 24)
			self.hour = self.hour % 24
			if self.day> 30 then
				self.month = self.month + math.floor(self.day / 30)
				self:getSeason()
				self.day = 1 + self.day/30 -math.floor(self.day / 30)
				if self.month>12 then
					self.year = self.year + math.floor(self.month / 12)
					self.month = 1 + self.month /12 - math.floor(self.month / 12)
				end
			end
		end
	end
end

function timer:draw()
	love.graphics.setColor(255,255,255)
	local text=string.format("现在是：%02d年%02d月%02d日%02d时%02d分,%s",self.year,self.month,self.day,self.hour,self.minut,self.season)
	love.graphics.printf(text, 100, 300, 800, "left")
	love.graphics.setColor(150, 255, 0)
	--love.graphics.print("心树开发中", 100, 400)

end


return timer
local timer = Class("timer")


function timer:init()
	self.year=0
	self.month =1
	self.day=1
	self.hour=12
	self.minut=0
	self.hourTotal=0
	self.multiply=50
	self.debug=true
	self.nextCheck=0
end

function timer:getSeason(month)
	if month<3 then
		self.season="winter"
	elseif month<6 then
		self.season="spring"
	elseif month<9 then
		self.season="summer"
	elseif month<12 then
		self.season="autumn"
	else
		self.season="winter"
	end

end






function timer:update(dt)
	self.minut=self.minut+dt*self.multiply
	if self.minut>60 then
		self.hour = self.hour + math.floor(self.minut / 60)
		self.hourTotal = self.hourTotal + math.floor(self.minut / 60)
		self.minut = 1
		if self.hour>24 then
			self.day = self.day + math.floor(self.hour / 24)
			self.hour = 1
			if self.day> 30 then
				self.month = self.month + math.floor(self.day / 30)
				self:getSeason(self.month)
				self.day = 1
				if self.month>12 then
					self.year = self.year + math.floor(self.month / 12)
					self.month = 1
				end
			end
		end
	end
end

function timer:draw()
	love.graphics.setColor(255,255,255)
	local text=string.format("现在是：%02d年%02d月%02d日%02d时%02d分",self.year,self.month,self.day,self.hour,self.minut)
	love.graphics.printf(text, 100, 300, 800, "left")
	love.graphics.setColor(150, 255, 0)
	love.graphics.print("心树开发中", 100, 400)
end


return timer
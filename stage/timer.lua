local timer = Class("timer")


function timer:init()
	self.year=0
	self.month =1
	self.day=1
	self.hour=0
	self.minut=0
	self.multiply=100
	self.debug=true
end



function timer:update(dt)
	self.minut=self.minut+dt*self.multiply
	if self.minut>60 then
		self.hour = self.hour + math.floor(self.minut / 60)
		self.minut = 1
		if self.hour>24 then
			self.day = self.day + math.floor(self.hour / 24)
			self.hour = 1
			if self.day> 30 then
				self.month = self.month + math.floor(self.day / 30)
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
	if self.debug  then 
		local line =0
		for k,v in pairs(self) do
			line= line+1
			love.graphics.print(k..","..tostring(v), 100,50*line)	
		end
	end
end


return timer
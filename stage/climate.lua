local climate={}
climate.lastSum=0
climate.weatherIndex=0.5
climate.lastDay=0
climate.nextCheck=0
climate.lastWeather=0.5

function climate:getSunIndex()
	local dayOfYear = (game.timer.month-1)*30+game.timer.day-1+game.timer.hour/24+game.timer.minut/1440
	local day = dayOfYear +game.timer.year*360
	local ind=1-math.abs(dayOfYear-180)*0.0016666
	self.sunIndex=ind
	self.currentDay=day
	self.lastWind=0
	self.wind=0
end

function climate:getWeatherIndex()
	if self.currentDay<self.nextCheck then return end
	self.lastWeather=self.weatherIndex
	self.lastDay=self.currentDay
	local index = love.math.randomNormal(0.2, 0.5)
	if index>1 then index=1 end
	if index<0 then index=0 end
	self.lastWind = self.wind
	self.wind = (love.math.noise(self.currentDay/2)-0.5)*15
	self.weatherIndex=index
	self.changeDurant = 0.5+love.math.random()*3
	self.nextCheck=self.currentDay+self.changeDurant
	self:getStep()
end

function climate:getStep()
	self.changeStep=(self.weatherIndex-self.lastWeather)/(self.changeDurant/3)
end

function climate:setParam()
	game.bg.sun:reset(self.sunIndex)
	game.temperature = -20 + (self.sunIndex-0.7)*180
	game.wind = self.lastWind
	local b = self.setIndex>0.5 and 0 or self.setIndex-0.5
	game.brightness = 1-(1 - self.sunIndex)*0.3- b
	game.colorful= game.brightness

	game.fg.cloud:reset(self.setIndex)
	game.fg.rain:reset(self.setIndex)
end

function climate:update()
	self:getSunIndex()
	self:getWeatherIndex()
	if self.currentDay-self.lastDay<self.changeDurant/3 then
		self.setIndex=self.lastWeather+self.changeStep*(self.currentDay-self.lastDay)
	end
	self.lastWind = self.lastWind + (self.wind-self.lastWind)/10
	self:setParam()
end


function climate:draw()
	
end
return climate
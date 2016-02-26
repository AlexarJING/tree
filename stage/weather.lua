local weather=Class "weather"


--sunny heavy light 
function weather:init()
	self.lastWeather="sunny"
	self.param={
		brightness=1,
		colorful=1,
		cloudThick=0,
		cloudColor=1,  --0 for dark  1 for bright
		rainCD=1,   --drop density
		thunder=0,
		wind=0,
	}
	self.step={
		brightness=0,
		colorful=0,
		cloudThick=0,
		cloudColor=0,  
		rainCD=0,   
		thunder=0,
		wind=0,
	}
end

function weather:getRainRate()
	self.rainRate=0.6-math.abs(self.month-7)*0.07
end

function weather:getTemperature()
	self.temperature= 32 - math.abs(self.month-7)*7
end

function weather:getChangeStep()
	for k,v in pairs(self.param) do
		self.step[k]=(self.target[k]-v)/self.duration
	end
end

function weather:step()
	for k,v in pairs(self.param) do
		v=v+(self.nextCheck-game.timer.hourTotal)*self.step[k]
	end
end

function weather:set()
	game.bg.brightness=self.param.brightness
	game.bg.colorful=self.param.colorful
	game.fg.cloud:reset(self.param.cloudThick,self.param.cloudColor)
	game.fg.rain:reset(self.param.rainCD,self.param.thunder)
	game.fg.wind=self.param.wind
end



function weather:change()
	local rnd=lm.random()
	local duration
	if rnd<self.rainRate then
		duration=3 + lm.random()*48
		self.currentWeather="rain"
		self.target={
			brightness=0.5,
			colorful=0.01,
			cloudThick=1,
			cloudColor=0.3,  --0 for dark  1 for bright
			rainCD=1,   --drop density
			thunder=1,
			wind=3,
		}
	else
		duration=24
		self.currentWeather="sunny"
		self.param={
			target=1,
			colorful=1,
			cloudThick=0,
			cloudColor=1,  --0 for dark  1 for bright
			rainCD=1,   --drop density
			thunder=0,
			wind=0,
		}
	end
	self:getChangeStep()
	self.duration=duration
	self.nextCheck=game.timer.hourTotal+duration

end



function weather:update()
	self:getRainRate()
	self:getTemperature()
	if game.timer.hourTotal>self.nextCheck then
		self:change()
	else
		self:step()
	end

end


function weather:draw()


end

return weather
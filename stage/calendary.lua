local cal=Class("calendary")

function cal:init(game)
	self.parent=game
	self.debug=true
	self.calendary={}
	
	self.state={
		spring={
			rainRate=0.3,
			sunRate=0.5
		},
		summer={
			rainRate=0.2,
			sunRate=0.7
		},
		autumn={
			rainRate=0.1,
			sunRate=0.8
		},
		winter={
			rainRate=0.2,
			sunRate = 0.7
		}
	}
	self.last=0
	self:update()
end

function cal:newRain()
	local duration= 12+(0.5-lm.random())*12
end

function cal:newSun()
	local heavy=50

end
function cal:newCloudy()
	local heavy=50

end

function cal:update()
	local day = self.parent.timer.day
	local month = self.parent.timer.month
	if self.day==day then 
		return 
	else
		self.day=day
		self.last=self.last-1
		if self.last>0 then
			return
		end
	end
	
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

	local rnd=lm.random()
	if self.state[self.season].rainRate>rnd then
		self:newRain()
	elseif self.state[self.season].sunRate+self.state[self.season].rainRate>rnd then
		self:newSun()
	else
		self:newCloudy()
	end
end



return cal

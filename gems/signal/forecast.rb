require 'signal'
require 'date'

class Wheather
	attr_reader :date, :max, :min, :time, :wind

	def initialize(date, max, min, time, wind)
		@date = date
		@max = max
		@min = min
		@time = time 
		@wind = wind
	end

	def to_s
		"date: #{date}-max: #{max}-min: #{min}-time: #{time}-wind: #{wind}"
	end
end

class Forecast < Hash
	def get(date)
		self.fetch("#{date.year},#{date.month},#{date.mday}", nil)
	end
end

class Timer 
	include Signal
	attr_reader :today

	def initialize(forecast)
		@forecast = forecast
		@today = Date.new(2016,11,1)
		on(:no_prevision) { notice_no_prevision! }
		on(:umbrella) { notice_umbrella! }
		on(:strong_wind) { notice_strong_wind! }
		on(:fall_of_temperature) { notice_fall_of_temperature! }
	end

	def next!
		@today = @today + 1
		check!
	end

	def notice_no_prevision!
		puts "#{@today} - Não tem previsão para hoje"
	end

	def notice_umbrella!
		puts "#{@today} - Traga um guardachuva pq hj vai chover"
	end

	def notice_strong_wind!
		puts "#{@today} - Hoje tem ventania, espero que você seja gordo"
	end

	def notice_fall_of_temperature!
		puts "#{@today} - Pega um benegripe pq hoje está muito mais frio que ontem"
	end

	private
	def check!
		emit(:no_prevision) unless prevision?
		emit(:umbrella) if umbrella?
		emit(:strong_wind) if strong_wind?
		emit(:fall_of_temperature) if fall_of_temperatura?
	end

	def prevision?
		! @forecast.get(@today).nil?
	end

	def umbrella?
		prevision? && @forecast.get(@today).time == 'CHUVA'
	end

	def strong_wind?
		prevision? && @forecast.get(@today).wind > 15
	end

	def fall_of_temperatura?
		yesterday_wheather = @forecast.get(@today - 1)
		current_wheather = @forecast.get(@today)
		(yesterday_wheather.max - current_wheather.max) > 8
	end
end

a = Wheather.new(Date.new(2016,11,2), 30, 22, 'SOL', 		10)
b = Wheather.new(Date.new(2016,11,3), 32, 24, 'SOL', 		12)
c = Wheather.new(Date.new(2016,11,4), 22, 17, 'NUBLADO', 	20)
d = Wheather.new(Date.new(2016,11,5), 17, 14, 'CHUVA', 		9)

f = Forecast.new
f['2016,11,2'] = a
f['2016,11,3'] = b
f['2016,11,4'] = c
f['2016,11,5'] = d

timer = Timer.new(f)
timer.next!
timer.next!
timer.next!
timer.next!
timer.next!

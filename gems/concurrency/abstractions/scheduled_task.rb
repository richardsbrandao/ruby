require 'concurrent'
require 'thread' # for Queue
require 'open-uri' # for open(uri)
require 'json'

class CurrencyQuotation
  def get_quotation(date, currencyBase, currencyTo)
    uri = "http://api.fixer.io/#{date}?base=#{currencyBase}&symbols=#{currencyTo}"
    data = open(uri) { |f| f.collect { |line| line.strip } }
    Quotation.new(JSON.parse(data[0], symbolize_names: true))
  end
end

class Quotation
  def initialize(data)
    @base = data[:base]
    @to = data[:rates].keys.first
    @value = data[:rates].values.first
    @date = data[:date]
  end

  def to_s
    "base=#{@base}to=#{@to}value=#{@value}date=#{@date}"
  end
end

class FutureLogger
  def update(time, value, reason)
    puts "Time: #{time} - Value: #{value} - Reason: #{reason}"
  end
end

schedule_3_sec = Concurrent::ScheduledTask.execute(3 ){ CurrencyQuotation.new.get_quotation('latest', 'BRL', 'USD') }
schedule_3_sec.add_observer FutureLogger.new

sleep 1
puts "1 sec state: #{schedule_3_sec.state}"
sleep 1
puts "2 secs state: #{schedule_3_sec.state}"
sleep 1
puts "3 secs state: #{schedule_3_sec.state}"

sleep 2
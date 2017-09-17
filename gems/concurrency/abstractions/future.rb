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

future_brl = Concurrent::Future.execute { CurrencyQuotation.new.get_quotation('latest', 'BRL', 'USD') }
puts future_brl
future_brl.add_observer FutureLogger.new

future_aaa = Concurrent::Future.execute { CurrencyQuotation.new.get_quotation('latest', 'AAA', 'USD') }
puts future_aaa
future_aaa.add_observer FutureLogger.new
sleep 1
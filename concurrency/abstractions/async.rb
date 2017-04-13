require 'concurrent'

class BackgroundLogger
  include Concurrent::Async

  def info(msg)
    puts "#{msg}"
  end

end

logger = BackgroundLogger.new

puts 'Sync method'
(1..10).each do |v|
  puts 'doing some synchronous process'
  logger.info "Log #{v}"
end

puts 'Async method'
(1..10).each do |v|
  puts 'doing some synchronous process'
  logger.async.info "Log #{v}"
end

sleep 1

class WebService
  def receive(arg)
    puts "Receiving #{arg}"
    Workflow.new.async.process(arg)
    send_ok(arg)
  end

  private
  def send_ok(arg)
    puts "Send Ok #{arg}"
  end
end

class Workflow
  include Concurrent::Async

  def process(arg)
    puts "Workflow call #{arg}"
  end
end

WebService.new.receive(1)
sleep 1


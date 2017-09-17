require 'concurrent'

module FileUtils
  def self.read(path)
    file = File.open(path, 'r')
    Concurrent::Maybe.just file.read
  rescue => e
    Concurrent::Maybe.nothing e.message
  ensure
    file.close if file
  end
end

class PrintResultMaybe
  def print(maybe)
    if maybe.just?
      puts "success: #{maybe.value}"
    else
      puts "fail: #{maybe.reason}"
    end
  end
end

success_maybe = FileUtils::read('./example.csv')
PrintResultMaybe.new.print success_maybe

fail_maybe = FileUtils::read('./fail.csv')
PrintResultMaybe.new.print fail_maybe
class UserWelcomeJob < ApplicationJob
  queue_as :default

  def perform(*users)
    puts "hello users: #{users}"
  end
end

class NewsletterJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Rails.logger.info "#{self.class.name} Performing with #{args.inspect}"
  end
end

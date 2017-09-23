class NewsletterWorker
	@queue = :newsletter

	def self.perform(emails)
		emails.each do |email|
			Rails.logger.info "Sending email for #{email}"
		end
	end
end
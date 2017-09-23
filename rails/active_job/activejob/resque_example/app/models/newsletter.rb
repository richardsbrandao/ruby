class Newsletter
	attr_reader :id, :emails

	def initialize(id, emails)
		@id, @emails = id, emails
	end

	def self.find(id)
		@repository[id]
	end

	def enqueue
		Resque.enqueue(NewsletterWorker, @emails)
	end

	private

	@repository = [
		Newsletter.new(0, ['richard.brandao@gmail.com', 'carlos.alberto@gmail.com', 'ana.cristina@gmail.com', 'ketherin.brandao@gmail.com']), 
		Newsletter.new(1, ['atendimento@simonsen.br', 'atendimento@senac.br', 'atendimento@santamonica.br'])
	]
end

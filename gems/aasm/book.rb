# Quero Ler? => Lendo 		=> Lido 	=>  Relendo?
#				Lendo 		=> Lido 	=>  Avaliado?
#		 					   Relendo?
#			   Abandonei
require 'aasm'

class Book
	include AASM

	aasm do
		state :wanting, :initil => true
		state :reading
		state :read
		state :rereading
		state :evaluated

		after_all_transitions :log_status

		event :start_reading do
			transitions :from => :wanting, :to => :reading
		end

		event :finilize do
			transitions :from => :reading, :to => :read
		end

		event :start_rereading do
			transitions :from => :read, :to => :rereading
		end

		event :evaluate do
			transitions :from => [:read, :rereading], :to => :evaluated
		end
	end

	def log_status
		puts "changing from '#{aasm.from_state}' to '#{aasm.to_state}' (event: #{aasm.current_event})"
	end
end

def debug(book)
	puts '------------------------------'
	puts "wanting? 		#{book.wanting?}"
	puts "reading? 		#{book.reading?}	may_reading?	#{book.may_start_reading?}"
	puts "read? 			#{book.read?}	may_read?	#{book.may_finilize?}"
	puts "rereading? 		#{book.rereading?}	may_rereading?	#{book.may_start_rereading?}"
	puts "evaluated? 		#{book.evaluated?}	may_evaluated?	#{book.may_evaluate?}"	

end

book = Book.new
debug(book)

book.start_reading
debug(book)

book.finilize
debug(book)

book.start_rereading
debug(book)

book.evaluate
debug(book)
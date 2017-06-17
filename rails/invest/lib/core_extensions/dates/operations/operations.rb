module Dates
	module Operations
		def diff_in_months_from_now(date)
			12 * (date.year - self.year) + date.month - self.month
		end
	end
end
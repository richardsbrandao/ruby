# frozen_string_literal: true

module Dates
  module Operations
    def diff_in_months_from_now(date)
      12 * (date.year - year) + date.month - month
    end
  end
end

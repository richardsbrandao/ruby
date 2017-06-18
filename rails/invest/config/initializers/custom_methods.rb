# frozen_string_literal: true

require "#{Rails.root}/lib/core_extensions/numbers/operations/operations"
BigDecimal.include Numbers::Operations

require "#{Rails.root}/lib/core_extensions/dates/operations/operations"
DateTime.include Dates::Operations

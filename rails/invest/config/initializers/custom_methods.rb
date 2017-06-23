# frozen_string_literal: true

require Rails.root.join('lib', 'core_extensions', 'numbers', 'operations', 'operations')
Integer.include Numbers::Operations


require Rails.root.join('lib', 'core_extensions', 'dates', 'operations', 'operations')
DateTime.include Dates::Operations

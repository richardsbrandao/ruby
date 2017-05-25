class Company < ApplicationRecord
  paginates_per 2
  max_paginates_per 20 # Max per page
end

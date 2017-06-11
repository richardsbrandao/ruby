class Company < ApplicationRecord
  paginates_per 2
  max_paginates_per 20 # Max per page

  acts_as_paranoid

  def self.cached_find(id)
    Rails.cache.fetch([self, "company#{id}"]) { with_deleted.find(id) }
  end
end

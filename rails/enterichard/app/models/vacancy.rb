class Vacancy < ApplicationRecord
  belongs_to :company, touch: true

  acts_as_paranoid

  after_commit :flush_cache

  def company
    # Company.unscoped { super }
    # Rails.cache.fetch([self, "company-#{id}"]) { Company.unscoped { super } }
    Company.cached_find(self.company_id)
  end

  def self.cached_all
    # all
    Rails.cache.fetch([self, 'all']) { self.all.to_a }
  end

  def self.cached_find(id)
    #find(id)
    Rails.cache.fetch([self, "vacancy#{id}"]) { find(id) }
  end

  def deleted?
    deleted_at.present?
  end

  def flush_cache
    # Mem cache nao suporte o delete normal (https://stackoverflow.com/questions/12005412/rails-cache-clear-certain-key-names)
    Rails.cache.delete_matched("#{self.class.name}/all")
    #Rails.cache.delete([self, "vacancy#{self.id}"]  )
  end
end

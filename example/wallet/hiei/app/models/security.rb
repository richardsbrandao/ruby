class Security < ActiveRecord::Base
  belongs_to :indexer

  enum tax_type: [:NO_TAX, :FIXED_INCOME, :PRIVATE_SOCIAL_SECURITY, :STOCK]
  enum yield_type: [:MONTHLY, :DAILY, :YEARLY]

  validates :name, presence: true
  validates :indexer_id, presence: true
  validates :tax_type, presence: true
  validates :expiration, presence: true
  validates :yield_type, presence: true
end

class Customer < ActiveRecord::Base
	has_many :addresses

	validates :name, presence: true
	validates :email, presence: true, email: true
	validates :cpf, presence: true, uniqueness: true

end

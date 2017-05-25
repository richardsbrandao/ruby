class Employee < ApplicationRecord
  belongs_to :vacancy
  has_and_belongs_to_many :skills
end

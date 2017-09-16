class Skill < ApplicationRecord
	has_and_belongs_to_many :employees
	has_and_belongs_to_many :vacancies

	enumerate :category, :with => Speciality
	validates_inclusion_of :category, :in => Speciality
end

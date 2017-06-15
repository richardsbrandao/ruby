module Ability
	extend ActiveSupport::Concern

	included do 
		has_and_belongs_to_many :skills
		scope :find_by_skill_name, -> (skill_name) { joins(:skills).where('skills.name': skill_name) }	
	end

	def has_skill?(skill_name)
		skills.select { |skill| skill_name == skill.name }.present?
	end
end
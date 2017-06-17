class VacancyMailer < ApplicationMailer
	default from: "richardsbrandao@gmail.com"

	def alert_job_by_skill_name(vacancy, skill_name)
		employees = Employee.find_by_skill_name(skill_name)
		@parameters = {company_name: vacancy.company.name, skill_name: skill_name}
		# employees.each do |employee|
		# employee.email
		# from: 'richardsbrandao@gmail.com', 
		mail(to: 'richardsbrandao@gmail.com', subject: "Alo #{skill_name} job", 
			template_name: 'alert_job')
		# end
	end 
end

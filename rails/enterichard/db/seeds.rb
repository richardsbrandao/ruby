Skill.all.each { |skill| skill.destroy }
Employee.all.each { |employee| employee.destroy }
Vacancy.all.each { |vacancy| vacancy.destroy }
Company.all.each { |company| company.destroy }

companies = Company.create([
	{name: 'M4U', foundation: 10.years.ago}, 
	{name: 'OLX', foundation: 4.years.ago}, 
	{name: 'B2W', foundation: 8.years.ago},
  {name: '99', foundation: 1.year.ago},
  {name: 'Uber', foundation: 8.years.ago},
	{name: 'Google', foundation: 19.years.ago},
	{name: 'Microsoft', foundation: 42.years.ago},
	{name: 'Apple', foundation: 41.years.ago},
])

vacancies = Vacancy.create([
	{position: 'Pleno', salary: 6000, company: companies.first},
	{position: 'Senior', salary: 9000, company: companies.first},
	{position: 'Junior', salary: 5000, company: companies.second},
	{position: 'Estagiario', salary: 1000, company: companies.third},
	{position: 'Pleno', salary: 5000, company: companies.third},
	{position: 'Senior', salary: 10000, company: companies.second}
])

employees = Employee.create([
	{name: 'Joaozinho', email: 'richardsbrandao@gmail.com', birthday: '1987-03-19 10:30:14'.to_date, gender: 'M', city: 'Rio de Janeiro', vacancy: vacancies.first},
	{name: 'Zeca', email: 'richardsbrandao@gmail.com', birthday: '1996-07-11 10:30:14'.to_date, gender: 'M', city: 'São Paulo', vacancy: vacancies.second},
	{name: 'Josefina', email: 'richardsbrandao@gmail.com', birthday: '1990-05-19 10:30:14'.to_date, gender: 'F', city: 'Amazonas', vacancy: vacancies.third},
	{name: 'Sassa', email: 'richardsbrandao@gmail.com', birthday: '1987-12-30 10:30:14'.to_date, gender: 'M', city: 'Rio de Janeiro', vacancy: vacancies.fourth},
	{name: 'West', email: 'richardsbrandao@gmail.com',birthday: '1985-11-12 10:30:14'.to_date, gender: 'M', city: 'São Paulo', vacancy: vacancies.fifth},
	{name: 'Paulinho', email: 'richardsbrandao@gmail.com', birthday: '1983-11-20 10:30:14'.to_date, gender: 'M', city: 'Rio de Janeiro', vacancy: vacancies.last}
])

skills = Skill.create([
	{name: 'Java', category: 'BACKEND'},
	{name: 'Ruby', category: 'BACKEND'},
	{name: 'Oracle', category: 'BACKEND'},
	{name: 'Node', category: 'BACKEND'},
	{name: 'Mongo', category: 'BACKEND'},
	{name: 'Photoshop', category: 'DESIGN'},
	{name: 'Html', category: 'DESIGN'},
	{name: 'Javascript', category: 'BACKEND'},
	{name: 'CSS', category: 'DESIGN'},
	{name: 'IOS', category: 'MOBILE'},
])

Skill.first.employees =  [Employee.first,    Employee.third]
Skill.second.employees = [Employee.second,   Employee.third]
Skill.third.employees =  [Employee.fourth,   Employee.last]
Skill.fourth.employees = [Employee.all.last, Employee.fifth]
Skill.fifth.employees =  [Employee.all.last, Employee.second]
Skill.all[6].employees = [Employee.first,    Employee.second]
Skill.all[7].employees = [Employee.third,    Employee.fifth]
Skill.all[8].employees = [Employee.second,   Employee.fifth]
Skill.all[9].employees = [Employee.first,    Employee.all.last]

Skill.first.vacancies = [Vacancy.first]
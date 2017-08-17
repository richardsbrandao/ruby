# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Contact.all.each do |contact|
	puts "Deletando #{contact.name}"
	contact.destroy
end

puts 'Criando Richard'
Contact.new( name: 'Richard', email: 'richardsbrandao@gmail.com', phone: '975599630', birthday: Time.now, facebook: 'meuface' ).save

10.times do |i|
	full_name = "#{Faker::Name.first_name}.#{Faker::Name.last_name}"
	puts "Criando #{full_name}"
	email = Faker::Internet.free_email(full_name)
	birthday = Faker::Date.backward(10000)
	phone = Faker::Number.number(8)

	Contact.new( name: full_name, email: email, phone: phone, birthday: birthday, facebook: "http://facebook.com/#{full_name}" ).save
end





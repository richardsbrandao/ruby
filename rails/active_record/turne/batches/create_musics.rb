require 'csv'

dir = "#{Dir.pwd}/batches/cds"
cds = Dir.new(dir).select { |file| ! ['.', '..'].include? file }

cds.each do |cd_file|
	cd_title = cd_file.gsub('.txt', '')
	csv_text = File.read("#{dir}/#{cd_file}")
	csv = CSV.parse(csv_text, :headers => false, :col_sep => ';')
	cd = Cd.find_by!(title: cd_title)
	cd.tracks = []
	csv.each do |row|
		cd.tracks << Track.find_or_initialize_by(name: row.first, duration: row.second)
	end
	cd.save
end
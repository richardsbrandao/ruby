
Band.with_ex_members
Band.oldest_than(1990)
Band.with_ex_members.oldest_than(2000)


Band.oldest_than(1995).order(year: :asc).limit(1)

# Track Load (15.6ms)  SELECT  "tracks".* FROM "tracks" ORDER BY "tracks"."id" ASC LIMIT ?  [["LIMIT", 1000]]                                                               
#   Track Load (9.4ms)  SELECT  "tracks".* FROM "tracks" WHERE ("tracks"."id" > 1000) ORDER BY "tracks"."id" ASC LIMIT ?  [["LIMIT", 1000]] 

Track.find_each(:batch_size => 100) do |track| 
#Track.find_each do |track| 
	track.name 
end

Track.find_by_sql('SELECT * FROM TRACKS limit 1')

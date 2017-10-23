
Band.with_ex_members
Band.oldest_than(1990)
Band.with_ex_members.oldest_than(2000)



Band.oldest_than(1995).order(year: :asc).limit(1)
Cd.all.each(&:destroy)
Category.all.each(&:destroy)
BandMember.all.each(&:destroy)
Band.all.each(&:destroy)
Musician.all.each(&:destroy)

Category.create([
	{name: 'Pop'},
	{name: 'Rock'},
	{name: 'Pop Rock'},
	{name: 'Rock Alternativo'}
])

Band.create([
	{name: 'Red Hot Chili Peppers ', year: 1983, category: Category.second},
	{name: 'Coldplay', year: 1996, category: Category.third},
	{name: 'Muse', year: 1994, category: Category.fourth},
	{name: 'Marron 5', year: 1994, category: Category.first}
])


Musician.create([
	{name: 'Anthony Kiedis', 			born: '1962-11-01'.to_date, country: 'EUA'},
	{name: 'Flea', 						born: '1962-10-16'.to_date, country: 'AUSTRALIA'},
	{name: 'Chad Smith', 				born: '1961-10-25'.to_date, country: 'EUA'},
	{name: 'Josh Klinghoffer', 			born: '1970-10-03'.to_date, country: 'EUA'},
	{name: 'John Frusciante', 			born: '1990-03-05'.to_date, country: 'EUA'},
	{name: 'Chris Martin', 				born: '1977-03-02'.to_date, country: 'INGLATERRA'},
	{name: 'Guy Berryman', 				born: '1978-04-12'.to_date, country: 'ESCOCIA'},
	{name: 'Johhny Buckland', 			born: '1977-09-11'.to_date, country: 'INGLATERRA'},
	{name: 'Will Champion', 			born: '1978-07-31'.to_date, country: 'INGLATERRA'},
	{name: 'Matthew Bellamy', 			born: '1778-06-09'.to_date, country: 'INGLATERRA'},
	{name: 'Christopher Wolstenholme', 	born: '1978-12-02'.to_date, country: 'INGLATERRA'},
	{name: 'Domenic Howard', 			born: '1977-12-07'.to_date, country: 'INGLATERRA'},
	{name: 'Adam Lavine', 				born: '1979-03-18'.to_date, country: 'EUA'},
	{name: 'James Valentine', 			born: '1978-10-05'.to_date, country: 'EUA'}, 
	{name: 'Mickey Madden', 			born: '1979-05-13'.to_date, country: 'EUA'}, 
	{name: 'Matt Flynn', 				born: '1970-05-23'.to_date, country: 'EUA'}
])

all_musicians = Musician.all

BandMember.create([
	{ band: Band.first,  musician: Musician.first,  	role: 'VOCALIST', 		arrival_at: 1983, departure_at: nil },
	{ band: Band.first,  musician: Musician.second, 	role: 'BASS_PLAYER', 	arrival_at: 1983, departure_at: nil },
	{ band: Band.first,  musician: Musician.third,  	role: 'DRUMMER', 		arrival_at: 1988, departure_at: nil },
	{ band: Band.first,  musician: Musician.fourth, 	role: 'GUITAR_PLAYER', 	arrival_at: 2009, departure_at: nil },
	{ band: Band.first,  musician: Musician.fifth,  	role: 'GUITAR_PLAYER', 	arrival_at: 1988, departure_at: 2009 },
	{ band: Band.second, musician: all_musicians[5],  	role: 'VOCALIST', 		arrival_at: 1996, departure_at: nil },
	{ band: Band.second, musician: all_musicians[6],  	role: 'BASS_PLAYER', 	arrival_at: 1998, departure_at: nil },
	{ band: Band.second, musician: all_musicians[7],  	role: 'GUITAR_PLAYER', 	arrival_at: 1996, departure_at: nil },
	{ band: Band.second, musician: all_musicians[8],  	role: 'DRUMMER', 		arrival_at: 1996, departure_at: nil },
	{ band: Band.third,  musician: all_musicians[9],  	role: 'VOCALIST_GUITAR',arrival_at: 1994, departure_at: nil },
	{ band: Band.third,  musician: all_musicians[10],  	role: 'BASS_PLAYER', 	arrival_at: 1994, departure_at: nil },
	{ band: Band.third,  musician: all_musicians[11],  	role: 'DRUMMER', 		arrival_at: 1994, departure_at: nil },
	{ band: Band.fourth, musician: all_musicians[12],  	role: 'VOCALIST', 		arrival_at: 1994, departure_at: nil },
	{ band: Band.fourth, musician: all_musicians[13],  	role: 'GUITAR_PLAYER', 	arrival_at: 1996, departure_at: nil },
	{ band: Band.fourth, musician: all_musicians[14],  	role: 'BASS_PLAYER', 	arrival_at: 1994, departure_at: nil },
	{ band: Band.fourth, musician: all_musicians[15],  	role: 'DRUMMER', 		arrival_at: 1996, departure_at: nil }
])

Cd.create([
	{year: 1984, title: 'The Red Hot Chili Peppers', 				 sales: 800_000,    band: Band.first},
	{year: 1985, title: 'Freaky Styley', 							 sales: 500_000,    band: Band.first},
	{year: 1987, title: 'The Uplift Mofo Party Plan', 				 sales: 3_000_000,  band: Band.first},
	{year: 1989, title: 'Mother\' Milk', 							 sales: 6_000_000,  band: Band.first},
	{year: 1991, title: 'Blood Sugar Sex Magic', 					 sales: 17_000_000, band: Band.first},
	{year: 1995, title: 'One Hot Minute',  							 sales: 8_000_000,  band: Band.first},
	{year: 1999, title: 'Californication', 							 sales: 35_000_000, band: Band.first},
	{year: 2002, title: 'By the Way', 								 sales: 21_000_000, band: Band.first},
	{year: 2006, title: 'Sadium Arcadium', 							 sales: 16_000_000, band: Band.first},
	{year: 2011, title: 'I\'m with you', 							 sales: 7_000_000,  band: Band.first},
	{year: 2016, title: 'The Getaway', 								 sales: 831_000,    band: Band.first},
	{year: 2000, title: 'Parachutes', 								 sales: 14_000_000, band: Band.second},
	{year: 2002, title: 'A rush of bood to the head', 				 sales: 22_000_000, band: Band.second},
	{year: 2005, title: 'X&Y', 										 sales: 20_600_000, band: Band.second},
	{year: 2008, title: 'Viva La Vida or Death and all his friends', sales: 11_800_000, band: Band.second},
	{year: 2011, title: 'Mylo Xyloto', 								 sales: 9_000_000,  band: Band.second},
	{year: 2014, title: 'Ghost Stories', 							 sales: 4_600_000,  band: Band.second},
	{year: 2015, title: 'A head Full of Dreams', 					 sales: 5_000_000,  band: Band.second},
	{year: 1999, title: 'Showbiz', 									 sales: 350_000,    band: Band.third},
	{year: 2001, title: 'Origin of Symmetry', 						 sales: 1_000_000,  band: Band.third},
	{year: 2003, title: 'Absolution', 								 sales: 3_200_000,  band: Band.third},
	{year: 2006, title: 'Black Holes and Revalations',				 sales: 4_000_000,  band: Band.third},
	{year: 2009, title: 'The Resistance', 							 sales: 5_300_000,  band: Band.third},
	{year: 2012, title: 'The 2nd Law', 								 sales: 2_600_000,  band: Band.third},
	{year: 2015, title: 'Drones', 									 sales: 650_000,    band: Band.third},
	{year: 2002, title: 'Songs About Jane', 						 sales: 10_000_000, band: Band.fourth},
	{year: 2007, title: 'It Won\'t Be Soon Before Long', 			 sales: 7_000_000,  band: Band.fourth},
	{year: 2010, title: 'Hands All Over', 							 sales: 3_000_000,  band: Band.fourth},
	{year: 2012, title: 'Overexposed', 								 sales: 2_200_000,  band: Band.fourth},
	{year: 2014, title: 'V', 										 sales: 2_000_000,  band: Band.fourth}
])  
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Four  artists
Review.destroy_all
Drawing.destroy_all
Artist.destroy_all

p1, p2, p3, p4 = 4.times.map { Artist.create! }

# A drawing by p1
Drawing.create!(artist: p1)

# All the rest of the drawings are by p2
d1, d2, d3, d4 = 4.times.map { Drawing.create!(artist: p2) }

# Drawing 1 (by p2) already reviewed by p1
Review.create!(drawing: d1, artist: p1)

# Drawing 3 (by p2) reviewed by p3 and p4
Review.create!(drawing: d3, artist: p3)
Review.create!(drawing: d3, artist: p4)

# Drawing 4 (by p2) reviewed by only p3
Review.create!(drawing: d4, artist: p3)

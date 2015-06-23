# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


album = Album.create!(name: "Cats")

1.upto(2) do |num|
  File.open("db/cat#{num}.jpg") do |f|
    album.photos.create!(image: f, description: "cat pic no.#{num}")
  end
end

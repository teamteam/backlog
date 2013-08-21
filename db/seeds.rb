# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Creating backlog items ..."
[
  "view backlog",
  "view backlog item",
  "add item to backlog",
  "remove item on backlog page",
  "remove item on backlog item page",
  "edit backlog item",
  "complete backlog item"
].each do |backlog_item_name|
  BacklogItem.create :name => backlog_item_name
end
puts "... backlog items successfully created"

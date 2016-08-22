# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

MULTIPLIER = 10

Day.destroy_all
Month.destroy_all
Year.destroy_all
User.destroy_all
Activity.destroy_all

puts "Creating days"
1.upto(31) do |num|
  Day.create(day: num)
end

puts "Creating months"
1.upto(12) do |num|
  month_n = Date::MONTHNAMES[num]
  Month.create(month: num, month_name: month_n)
end

puts "Creating years"
1900.upto(2010) do |num|
  Year.create(year: num)
end

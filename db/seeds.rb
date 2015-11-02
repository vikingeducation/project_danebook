# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# --------------------------------------------
# Destroy Old Data
# --------------------------------------------

puts 'Destroying old data'
Rake::Task['db:migrate:reset'].invoke

# --------------------------------------------
# Create Genders
# --------------------------------------------

puts 'Creating genders'
GENDERS = [
  {:name => 'Male', :short_name => 'm'},
  {:name => 'Female', :short_name => 'f'}
]
Gender.create(GENDERS)

# --------------------------------------------
# Create Users
# --------------------------------------------

puts 'Creating users'
FIRST_NAMES = [
  'Moe',
  'Larry',
  'Curly',
  'Elmer',
  'Mickey',
  'Daffy',
  'Bugs',
  'Porky',
  'Minnie',
  'Tom',
  'Jerry'
]
LAST_NAMES = [
  'Fud',
  'Mouse',
  'Duck',
  'Bunny',
  'Pig',
  'Cat'
]
PASSWORD = 'password'
birthday_year_range = 18..50
gender_id_range = 1..Gender.count

users = []
FIRST_NAMES.each_with_index do |first_name, i|
  LAST_NAMES.each_with_index do |last_name, j|
    users << {
      :email => "#{first_name.downcase}@#{last_name.downcase}.com",
      :password => PASSWORD,
      :first_name => first_name,
      :last_name => last_name,
      :birthday => rand(birthday_year_range).years.ago,
      :gender_id => rand(gender_id_range)
    }
  end
end
User.create(users)

puts 'done!'






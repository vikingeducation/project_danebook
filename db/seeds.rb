# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

SCALE = 50
LOREM = "Lørem ipsum dolor sit amet, consectetur ådipisicing elit, sed do eiusmod tempor incididunt ut labore et doløre magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodö consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum doløre eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

User.destroy_all


genders = ['female', 'male']
password = 'password'

characters = [
  { first_name: "Moby", last_name: "Dick", birth_date: Faker::Date.between(100.years.ago, Date.today), gender: 'male', email: 'moby@viking.com', password: password, password_confirmation: password },
  { first_name: "Hägar", last_name: "the Horrible", birth_date: Faker::Date.between(100.years.ago, Date.today), gender: 'male', email: 'hagar@viking.com', password: password, password_confirmation: password },
  { first_name: "Æsbiorn", last_name: "the Violent", birth_date: Faker::Date.between(100.years.ago, Date.today), gender: 'male', email: 'aesbiorn@viking.com', password: password, password_confirmation: password },
  { first_name: "Dr. Stephen", last_name: "Maturin", birth_date: Faker::Date.between(250.years.ago, 230.years.ago), gender: 'male', email: 'stephen@viking.com', password: password, password_confirmation: password },
  { first_name: "Jacques-Yves", last_name: "Cousteau", birth_date: Faker::Date.between(100.years.ago, Date.today), gender: 'male', email: 'jacques@viking.com', password: password, password_confirmation: password },
  { first_name: "The", last_name: "Kraken", birth_date: Faker::Date.between(1000.years.ago, Date.today), gender: 'male', email: 'kraken@viking.com', password: password, password_confirmation: password },
  { first_name: "Beowulf", last_name: "of the Geats", birth_date: Faker::Date.between(1000.years.ago, 999.years.ago), gender: 'male', email: 'beowulf@viking.com', password: password, password_confirmation: password },
  { first_name: "Odysseus", last_name: "The Wanderer", birth_date: Faker::Date.between(3200.years.ago, 2800.years.ago), gender: 'male', email: 'odysseus@viking.com', password: password, password_confirmation: password },
  { first_name: "Wilson", last_name: "The Volleyball", birth_date: Faker::Date.between(20.years.ago, Date.today), gender: 'male', email: 'wilson@viking.com', password: password, password_confirmation: password },
  { first_name: "Horatio", last_name: "Hornblower", birth_date: Faker::Date.between(250.years.ago, 230.years.ago), gender: 'male', email: 'horatio@viking.com', password: password, password_confirmation: password },
  { first_name: "Ingrid", last_name: "the Magnificent
", birth_date: Faker::Date.between(100.years.ago, Date.today), gender: 'female', email: 'ingrid@viking.com', password: password, password_confirmation: password },
  { first_name: "Sebastian", last_name: "the Crab", birth_date: Faker::Date.between(20.years.ago, Date.today), gender: 'male', email: 'sebastian@viking.com', password: password, password_confirmation: password },
  { first_name: "Blackbeard", last_name: "The Blackhearted", birth_date: Faker::Date.between(250.years.ago, 230.years.ago), gender: 'male', email: 'blackbeard@viking.com', password: password, password_confirmation: password },
  { first_name: "Odin", last_name: "King", birth_date: Faker::Date.between(3200.years.ago, 2800.years.ago), gender: 'male', email: 'odin@viking.com', password: password, password_confirmation: password },
  { first_name: "Ancient", last_name: "Mariner", birth_date: Faker::Date.between(250.years.ago, 230.years.ago), gender: 'male', email: 'mariner@viking.com', password: password, password_confirmation: password },
  { first_name: "Brynhildr", last_name: "Valkyrie", birth_date: Faker::Date.between(3200.years.ago, 2800.years.ago), gender: 'female', email: 'brynhildr@viking.com', password: password, password_confirmation: password },
  { first_name: "Captain", last_name: "Nemo", birth_date: Faker::Date.between(250.years.ago, 230.years.ago), gender: 'male', email: 'nemo@viking.com', password: password, password_confirmation: password },
  { first_name: "Red", last_name: "Orm", birth_date: Faker::Date.between(1200.years.ago, 900.years.ago), gender: 'male', email: 'orm@viking.com', password: password, password_confirmation: password },
]

print "Creating users"
characters.each do |character|
  User.create!(character)
  print "."
end
puts

print "Creating posts"
SCALE.times do
  Post.create!(author_id: User.all.sample.id, text: LOREM[0..rand(LOREM.length)])
  print "."
end
puts

print "Creating comments"
SCALE.times do
  p = Post.all.sample.comments.build(commenter_id: User.all.sample.id, text: LOREM[0..rand(LOREM.length)])
  p.save!
  print "."
end
puts

print "Creating likes"
SCALE.times do
  p = Post.all.sample.likes.build(user_id: User.all.sample.id)
  p.save!
  print "."
  p = Comment.all.sample.likes.build(user_id: User.all.sample.id)
  p.save!
  print "."
end
puts

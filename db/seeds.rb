# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "deleting everything"
User.destroy_all
Profile.destroy_all
Post.destroy_all

puts "creating users"
User.create(email: "louisck@gmail.com", password: "asdfasdf", first_name: "Louis", last_name: "CK", gender: "male", birthdate: Date.parse("09/02/1977"))
User.create(email: "chrisrock@gmail.com", password: "zxcvzxcv", first_name: "Chris", last_name: "Rock", gender: "male", birthdate: Date.parse("11/11/1976"))
User.create(email: "johnwaters@gmail.com", password: "qwerqwer", first_name: "John", last_name: "Waters", gender: "male", birthdate: Date.parse("10/02/1937"))

puts "creating profiles"
User.first.create_profile(hometown: "Newton, MA", current_residence: "New York, New York", telephone: "555-555-5555", words_to_live_by: "I have no words to live by.", about_me: "I have no about me.")
User.second.create_profile(hometown: "Brooklyn, NY", current_residence: "Somewhere in Jersey", telephone: "555-555-5225", words_to_live_by: "Comedy is King.", about_me: "I do comedy.")
User.third.create_profile(hometown: "Baltimore, MD", current_residence: "Baltimore, MD", telephone: "555-555-5255", words_to_live_by: "Words? Words??", about_me: "Something orange.")

puts "creating posts"
User.first.posts.create(body: "This is a post by Louis CK, the comedian.")
User.first.posts.create(body: "I sure do like posting things.")
User.first.posts.create(body: "Go watch my new TV series on some channel at some time.")
User.second.posts.create(body: "Today was a good day.")
User.second.posts.create(body: "Today was an okay day.")
User.second.posts.create(body: "I wrote a funny joke today.")
User.third.posts.create(body: "Words? Words??")
User.third.posts.create(body: "Words..")
User.third.posts.create(body: "OK.")
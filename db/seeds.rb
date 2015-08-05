# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#User.destroy_all

MULTIPLIER = 20


def generate_user
  user = User.new
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  user.first_name = first_name
  user.last_name = last_name
  user.email = Faker::Internet.free_email(first_name)
  user.password = "password"
  user.password_confirmation = "password"
  #Between 1988 and 2001
  user.birthday = Faker::Time.between(Date.today - 5000, Date.today - 10000)
  user.gender = ["male", "female"].sample
  user.save
end

def generate_user_with_profile
  user = User.new
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  user.first_name = first_name
  user.last_name = last_name
  user.email = Faker::Internet.free_email(first_name)
  user.password = "password"
  user.password_confirmation = "password"
  #Between 1988 and 2001
  user.birthday = Faker::Time.between(Date.today - 5000, Date.today - 10000)
  user.gender = ["male", "female"].sample
  user.save

  profile_params = {college: Faker::Address.city + " University",
                    hometown: Faker::Address.city,
                    current_home: Faker::Address.city,
                    mobile: Faker::PhoneNumber.cell_phone,
                    summary: Faker::Lorem.sentence,
                    about: Faker::Lorem.paragraph,
                    user_id: user.id }

  profile = Profile.new(profile_params)
  profile.save
end


MULTIPLIER.times do
  generate_user_with_profile
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])



  (1..500).each do |i|
    Location.create!(
      city: Faker::Address.city,
      state: Faker::Address.state_abbr,
      country: Faker::Address.country,
      )
  end


  (1..500).each do |user|
    User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: "user#{user}@danebook.com",
      password: "foobar",
      password_confirmation: "foobar",
      gender: ["male","female"].sample,
      birth_month: rand(12)+1,
      birth_day: rand(28)+1,
      birth_year: (1920..1990).to_a.sample,
      words: Faker::Lorem.paragraph,
      about: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.phone_number,
      school_id: (1..300).to_a.sample,
      location_id: (1..500).to_a.sample,
      current_location_id: (1..500).to_a.sample
      )
  end

  (1..300).each do |school|
    School.create!(
      name: "#{Faker::Company.name} University"
      )
  end



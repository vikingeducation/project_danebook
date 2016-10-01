User.destroy_all
Profile.destroy_all

puts "creating 10 users.."
10.times do
  User.create(first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email,
              password: "password123",
              birthday: Faker::Date.between(50.years.ago, 5.years.ago),
              gender_cd: rand(2)
              )
end

puts "creating #{User.all.count} profiles.."
User.all.each do |u|
  Profile.create(user_id: u.id, college: Faker::University.name,
                 hometown: "#{Faker::Address.city}, #{Faker::Address.state}",
                 address: "#{Faker::Address.city}, #{Faker::Address.state}",
                 phone: Faker::PhoneNumber.cell_phone,
                 status: Faker::Hipster.sentence,
                 about: Faker::Hipster.paragraph
                )
end
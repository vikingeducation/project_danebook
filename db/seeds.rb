puts 'Deleting existing...'

resources = [User]
resources.each do |resource|
  puts "#{resource.count} #{resource}s"
  resource.destroy_all
end

puts '','Building new...'
puts 'Users w/o profiles'
User.create!([
  {email: 'alex@email.com', password: 'password'},
  {email: 'violet@email.com', password: 'password'},
  {email: 'zorro@email.com', password: 'password'}
])

puts 'Users with profiles'
5.times do
  user_name = Faker::HarryPotter.unique.character
  User.create!({
    name: user_name,
    email: Faker::Internet.email(user_name),
    birthday: Faker::Date.birthday(15, 25),
    hometown: Faker::HarryPotter.location,
    current_town: Faker::HarryPotter.location,
    college: Faker::University.name,
    phone: Faker::PhoneNumber.phone_number,
    quote: Faker::HarryPotter.quote,
    bio: Faker::Lorem.paragraph,
    headshot_pic: Faker::LoremPixel.image("150x150", false, 'people'),
    cover_pic: Faker::LoremPixel.image("770x230", false, 'nature'),
    password: 'password'
  })
end

puts "User count: #{User.count}"




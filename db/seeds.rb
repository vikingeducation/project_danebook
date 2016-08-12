# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts "Destroying Users"
if Rails.env == 'development'
  User.destroy_all
end

puts "Creating Users"
User.create!(email: 'harry_potter@hogwarts.edu', password: 'password',
  profile_attributes: {
    first_name: 'Harry',
    last_name: 'Potter',
    birthday: Date.new(1980, 7, 31),
    college: 'Hogwarts School',
    hometown: "Godrick's Hollow",
    currently_lives: "Godrick's Hollow",
    telephone: '867-5309',
    words_to_live_by: 'Lorem ipsum sapientem ne neque dolor erat,eros solet invidunt duo Quisque aliquid leo. Pretium patrioque',
    about_me: 'Lorem ipsum sapientem ne neque dolor erat,eros solet invidunt duo Quisque aliquid leo. Pretium patrioque sociis eu nihil Cum enim ad, ipsum alii vidisse justo id. Option porttitor diam voluptua. Cu Eam augue dolor dolores quis, Nam aliquando elitr Etiam consetetur. Fringilla lucilius mel adipiscing rebum. Sit nulla Integer ad volumus, dicta scriptorem viderer lobortis est Utinam, enim commune corrumpit Aenean erat tellus. Metus sed amet dolore justo, gubergren sed.'
  } )

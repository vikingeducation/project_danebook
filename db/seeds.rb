# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Destroying existing objects"
User.destroy_all
Post.destroy_all
Comment.destroy_all
Like.destroy_all

puts "Create users"

5.times do
  firstname = Faker::Name.first_name
  lastname = Faker::Name.last_name
  email = Faker::Internet.email
  birthday= 
  telephone = Faker::PhoneNumber
  password_digest = BCrypt::Password.create("foobar123")
  u = User.create!(
                  :lastname => lastname,
                  :password_digest => password_digest)
  Profile.create!(:firstname => firstname,
                  :lastname => lastname,

                  :gender => ["Male", "Female"].sample,
                  :telephone => telephone,
                  :college)
  }
end

    t.integer  "user_id"
    t.datetime "birthday"
    t.string   "college"
    t.string   "hometown"
    t.string   "currently_lives"
    t.text     "words_to_live_by"
    t.text     "about_me"
    t.datetime "created_at",       null: false
    t.datetime "updated_a
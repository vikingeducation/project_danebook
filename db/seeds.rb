# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


20.times do |n|

  User.create(:username => "foo#{n}",
              :email => "foo#{n}@bar.com",
              :password => "1234",
              :password_confirmation => "1234",
              :first_name => "foo#{n}",
              :last_name => "bar")

end
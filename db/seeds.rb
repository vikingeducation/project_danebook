puts 'Deleting existing...'

resources = [User]
resources.each do |resource|
  puts "#{resource.count} #{resource}s"
  resource.destroy_all
end

puts '','Building new...'
puts 'Users'
User.create!([
  {email: 'alex@email.com', password: 'password'},
  {email: 'violet@email.com', password: 'password'},
  {email: 'zorro@email.com', password: 'password'}
])
puts "User count: #{User.count}"

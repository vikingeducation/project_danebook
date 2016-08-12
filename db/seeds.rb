if Rails.env == "development"
  Rake::Task["db:migrate:reset"].invoke
end




User.create!({
  first_name: "Matt", 
  last_name: "Hinea",
  email: "Matthinea@email.com",
  password: "apassword",
  gender: "male", 
  :profile_attributes => {
    birth_date: Date.today
  }
  })
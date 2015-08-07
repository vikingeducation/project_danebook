module SignupMacros

  # Fills out the form with passing values. Override values by passing
  # them in as arguments in the format fill_out_signup_form(arg1: val1, arg2: val2)
  def fill_out_signup_form(**args)
    fill_in "user[first_name]", with: args[:first_name] || "Test"
    fill_in "user[last_name]", with: args[:last_name] || "Testy"
    fill_in "user[email]", with: args[:email] || "abc@foo.bar"
    fill_in "user[password]", with: args[:password] || "aaaaaaaa"
    fill_in "user[password_confirmation]", with: args[:password_confirmation] || "aaaaaaaa"

    select 14.years.ago.year.to_s, from: 'user_dob_1i'
    select 14.years.ago.strftime("%B"), from: 'user_dob_2i'
    select 14.years.ago.day.to_s, from: 'user_dob_3i'

    choose "user[gender]", option: 1
  end
end

module ProfilesHelper

  def show_birthday(profile)
    profile.user.birthday.nil? ? "No birthday specified" : profile.user.birthday.strftime("%B %d, %Y") 
  end

  def show_college(profile)
    @profile.college.nil? ? "Not specified" : @profile.college
  end
end

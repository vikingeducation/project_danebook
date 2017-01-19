class ProfileMailer < ApplicationMailer
  default from: "Sampson Crowley <sampsonsprojects@gmail>"

  def welcome(profile_id)
    @profile = Profile.includes(:user).find(profile_id)
    @title = "Velkommen to Danebook"
    mail(to: @profile.user.email, subject: "Velkommen! Explore your new Danebook account.")
  end
end

class Profile < ActiveRecord::Base
  belongs_to :user

  def email
    self.user.email
  end
end

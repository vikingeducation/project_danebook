class Post < ApplicationRecord

  belongs_to :user
  # belongs_to :profile, :through => :user

end

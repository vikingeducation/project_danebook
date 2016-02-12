class Post < ActiveRecord::Base

  belongs_to :user


  validates :body, :user_id, presence: true
  valides :body, length: { in: 1..250 }





end

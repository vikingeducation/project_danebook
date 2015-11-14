class Post < ActiveRecord::Base
  belongs_to :user

  validates :body,
            :presence => true

  validates :user,
            :presence => true

  def date
    created_at.strftime('%A, %B %e %Y')
  end
end

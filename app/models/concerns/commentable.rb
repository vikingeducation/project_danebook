module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :likes, as: :likable, dependent: :destroy
    has_many :people_who_like, through: :likes, source: :user
    belongs_to :author, class_name: "User", foreign_key: :user_id
    validates :body, presence: true
    validates :author, presence: true
  end

  def posted_on
    "Posted on " + self.created_at.strftime("%A %m/%d/%Y")
  end

end

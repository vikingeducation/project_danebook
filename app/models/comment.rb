class Comment < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy
  belongs_to :commentable, polymorphic: true
  after_create :send_comment_email

  validates :comment_text, presence: true

  private

  def send_comment_email
    unless current_user == self.user
      UserMailer.comment_alert(self).deliver!
    end
  end
end

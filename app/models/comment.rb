class Comment < ActiveRecord::Base
  include Dateable
  include Feedable
  include Notifiable

  feedable_user_method :user
  feedable_actions :create

  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  has_many :likes, :as => :likeable, :dependent => :destroy

  validates :body,
            :presence => true

  validates :user,
            :presence => true

  validate :presence_of_commentable


  private
  def presence_of_commentable
    unless commentable_id.present? && commentable_type.present?
      errors.add(:base, 'You cannot comment on that!')
    end
  end
end

class Activity < ActiveRecord::Base
  include Dateable

  belongs_to :user
  belongs_to :feedable, :polymorphic => true

  def self.feed_for(user)
    where(
      'user_id IN (?) OR user_id IN (?) OR user_id = ?',
      user.friendship_requesters.pluck(:id),
      user.friendship_accepters.pluck(:id),
      user.id
    ).order(:created_at => :desc)
  end

  def self.timeline_for(user)
    where(:user_id => user.id).order(:created_at => :desc)
  end
end

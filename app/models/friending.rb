class Friending < ActiveRecord::Base
  belongs_to :friender, class_name: "User"
  belongs_to :friended, class_name: "User"

  validates :friender, presence: true
  validates :friended, presence: true
  validates :friender_id, :uniqueness => { :scope => :friended_id, message: "can't friend the same user twice!"}

  after_create :create_activity
  after_destroy :destroy_activity

  private

    def create_activity
      Activity.create(
        user_id: self.friender_id,
        event: "Added a Friend",
        activable_id: self.id,
        activable_type: "#{self.class}",
        created_at: self.created_at,
        updated_at: self.updated_at
      )
    end

    def destroy_activity
      activity = Activity.find_by_user_id_and_activable_id_and_activable_type( self.user_id, self.id, "#{self.class}")
      activity.destroy
    end

    # def add_activities
    #   if friended.posts
    #     friended.posts.each do |post_activity|
    #       Activity.create(
    #         user_id: friender_id,
    #         event: "Added a friend",
    #         activable_id: self.id,
    #         activable_type: "#{self.class}" )
    #     end
    #   end
    #
    #   if friended.photos
    #     friended.photos.each do |photo_activity|
    #     end
    #   end
    # end
    #
    # def remove_activities
    #
    # end

    # => Activity.where(user_id: user.friendeds.pluck(:id))
end

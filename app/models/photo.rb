class Photo < ActiveRecord::Base
  belongs_to :user

  has_attached_file :photo, styles: { thumb: "100x100", medium: "250x250", large: "500x500>" }
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  validates_attachment_presence :photo, presence: true
  validates_with AttachmentSizeValidator, attributes: :photo, less_than: 5.megabytes

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :user, presence: true

  after_create :create_activity
  after_destroy :destroy_activity

  def photo_from_url(url)
    self.photo = open(url)
  end

  private

    def create_activity
      Activity.create(
        user_id: self.user_id,
        event: "Uploaded a Photo",
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

  # def create_activities
  #   if photo.user.frienders
  #     post.user.frienders.each do |friender|
  #       Activity.create(
  #         user_id: friender.id,
  #         event: "Uploaded a Photo",
  #         activable_id: self.id,
  #         activable_type: "#{self.class}" )
  #     end
  #   end
  # end

end

class Profile < ApplicationRecord
  before_save :format_input
  before_save :normalize_blank_values

  after_create :send_welcome_email

  enum gender_type: [:Male, :Female, :Other]

  belongs_to :user, inverse_of: :profile

  has_one :bio, dependent: :destroy
  accepts_nested_attributes_for :bio, reject_if: :all_blank

  has_one :profile_gallery, -> {where(title: "Profile Images")}, through: :user, source: :galleries
  accepts_nested_attributes_for :profile_gallery, reject_if: :all_blank

  has_many :images, through: :profile_gallery
  accepts_nested_attributes_for :images, reject_if: :all_blank

  belongs_to :profile_img, class_name: "Image", foreign_key: :image_id, optional: :true

  belongs_to :cover, class_name: "Image", foreign_key: :cover_id, optional: :true

  validates_presence_of :first_name, :last_name, :birthday, :gender
  validates_format_of :phone, with: /\A(?=.*\d)[0-9\- +]+\Z/, allow_nil: true, allow_blank: true
  validates :phone, length: { minimum: 4, maximum: 30 }, allow_nil: true, allow_blank: true


  def normalize_blank_values
    attributes.each do |column, value|
      self[column].present? || self[column] = nil
    end
  end

  default_scope {
    includes :profile_img
  }

  def self.genders
    gender_types.keys.to_a.map{|v| [v.humanize, v.to_s.classify]}
  end

  def fix_profile_image
    self.update_attribute(:profile_img, profile_gallery.images.last)
  end

  private
    def format_input
      first_name.capitalize! if first_name
      last_name.capitalize! if last_name
    end

    def send_welcome_email
      ProfileMailer.welcome(self.id).deliver_later
    end

end

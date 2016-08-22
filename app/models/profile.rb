class Profile < ActiveRecord::Base
  after_create :defaults


  ### Associations ###
  # Pointer to owner.
  belongs_to :user

  # Profile details.
  has_one :birthday, dependent: :destroy
  has_one :contact_info, dependent: :destroy
  has_one :hometown, dependent: :destroy
  has_one :residence, dependent: :destroy

  # Paperclip(cover) 
  has_attached_file :cover,default_url: "hogwarts_small.jpg"
  validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/
  before_validation { cover.clear if delete_cover == '1' }
  attr_accessor :delete_cover

  # Cover photo from among user's Photo
  has_one :profile_photo
  has_one :cover_photo, through: :profile_photo, source: :photo


  [:birthday, :contact_info, :hometown, :residence].each do |child|
    accepts_nested_attributes_for child
  end

  validates :first_name, :last_name, { presence: true, 
                                       length: { in: 1..255 } }



  private
    def defaults
      create_contact_info!
      create_birthday!
      create_hometown!
      hometown.create_address!
      create_residence!
      residence.create_address!
    end
end

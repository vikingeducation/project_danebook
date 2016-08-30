class User < ApplicationRecord
  before_create :generate_token

  has_secure_password

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  validates :password,
            :length => { :in => 3..24 },
            :allow_nil => true

  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end

  has_many :posts, :foreign_key => :author_id, :inverse_of => :author
  accepts_nested_attributes_for :posts,
                              :reject_if => :all_blank,
                              :allow_destroy => true

  has_many :comments, :foreign_key => :commenter_id, :inverse_of => :commenter

end

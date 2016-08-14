class User < ApplicationRecord
  has_secure_password
  before_create :generate_token
  has_one :profile, inverse_of: :user, dependent: :destroy
  has_many :posts
  has_many :likes

  accepts_nested_attributes_for :profile, update_only: true

  class EmailValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      record.errors.add attribute, "must contain a '@' symbol" unless value.include?('@')
    end
  end

  validates :password,
    :length => { :in => 6..24 },
    :allow_nil => true
  validates :email,
    email: true


  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])
  end

  def errors?
    errors.full_messages.any?
  end

  def includes_at_sym(email)
    email.include?('@')
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end
end

class User < ApplicationRecord
  has_secure_password
  before_create :generate_token

  class EmailValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      record.errors.add attribute, "must contain a '@' symbol" unless value.include?('@')
    end
  end
  validates :password,
    :length => { :in => 6..24 },
    :allow_nil => true
  validates :email,
    :length => { :in => 5..24 },
    email: true


  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])
  end

  def name
    first_name + ' ' + last_name
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

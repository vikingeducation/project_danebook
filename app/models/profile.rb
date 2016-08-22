class Profile < ApplicationRecord
  belongs_to :user, inverse_of: :profile
  validates :first_name, :last_name, :gender, :birthday, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def display_errors(attribute)
    message = ""
    if self.errors[attribute].any?
      message += "#{attribute.capitalize}"
      self.errors[attribute].each do |e|
        message += " #{e}"
      end
    end
    message
  end

  def self.search(query)
    if query
      where("first_name LIKE ? OR last_name LIKE?","%#{query}%","%#{query}%")
    else
      where("")
    end
  end

  
end

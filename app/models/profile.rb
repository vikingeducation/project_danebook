class Profile < ApplicationRecord

  validates :first_name, 
            :length => { :in => 2..40 }

  validates :last_name, 
            :length => { :in => 2..40 }

  belongs_to :user

  def name
    first_name + " " + last_name
  end

end

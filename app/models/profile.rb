class Profile < ActiveRecord::Base

  # ----------------------- Relationships --------------------

  belongs_to :user


  # ----------------------- Validations --------------------

  validates :user_id,
            uniqueness: true,
            presence: true

end

class Friending < ApplicationRecord
  belongs_to :friending_initiator, foreign_key: :friender, class_name: 'User'
  belongs_to :friending_recipient, foreign_key: :friendee, class_name: 'User'

  validate :friendee_does_not_equal_friender,
    :friending_does_not_exist

  private

  def friendee_does_not_equal_friender
    if friendee == friender
      errors.add(:friendee, "can't friend yourself!")
    end
  end

  def friending_does_not_exist
    if friending_initiator.friends_with?(friending_recipient)
      errors.add(:friendee, 'this friendship already exists')
    end
  end
end

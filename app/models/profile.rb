class Profile < ActiveRecord::Base
  has_one :birthday, dependent: :destroy
  has_one :contact_info, dependent: :destroy
  has_one :hometown, dependent: :destroy
  has_one :residence, dependent: :destroy

  [:birthday, :contact_info, :hometown, :residence].each do |child|
    accepts_nested_attributes_for child
  end
end

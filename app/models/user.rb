class User < ApplicationRecord
  has_one :profile
  accepts_nested_attributes_for :profile, reject_if: :all_blank
end

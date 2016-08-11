class Country < ActiveRecord::Base
  has_many :addresses, dependent: :nullify
end

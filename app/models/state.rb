class State < ActiveRecord::Base
  has_many :addresses, dependent: :nullify
end

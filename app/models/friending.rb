class Friending < ApplicationRecord
  belongs_to :initiator, foreign_key: :initiator_id, class_name: "User"
  belongs_to :reciever, foreign_key: :reciever_id, class_name: "User"
end

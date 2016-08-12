class Activity < ApplicationRecord
  belongs_to :postable, :polymorphic => true
  belongs_to :user

  def content
  end
end

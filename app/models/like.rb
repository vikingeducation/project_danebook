class Like < ActiveRecord::Base
  include Dateable
  
  belongs_to :user
  belongs_to :likeable, :polymorphic => true

  validates :user,
            :presence => true

  validate :presence_of_likeable


  private
  def presence_of_likeable
    unless likeable_type.present? && likeable_id.present?
      errors.add(:base, 'You cannot like that!')
    end
  end
end

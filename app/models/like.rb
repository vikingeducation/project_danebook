class Like < ActiveRecord::Base
  belongs_to :user  
  belongs_to :duty, :polymorphic => true  #changing duty to likings

  validates :user_id, :uniqueness => { scope: [:duty_id, :duty_type]}
  validates :duty_id, :duty_type, :presence => :true

end

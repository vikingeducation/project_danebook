class Profile < ActiveRecord::Base
    
    before_create :set_default_profile
    belongs_to :user
    
private
  def set_default_profile
    self.tel_number = "0000000000"
    self.words_to_live_by = "nothing has been written"
    self.about_me = "nothing has been written"
  end
end

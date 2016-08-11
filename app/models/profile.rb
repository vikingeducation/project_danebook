class Profile < ActiveRecord::Base
  after_save :defaults

  belongs_to :user
  has_one :birthday, dependent: :destroy
  has_one :contact_info, dependent: :destroy
  has_one :hometown, dependent: :destroy
  has_one :residence, dependent: :destroy

  [:birthday, :contact_info, :hometown, :residence].each do |child|
    accepts_nested_attributes_for child
  end

  #pg_search
  include PgSearch
  #Defining a pg search scope
  pg_search_scope :search_by_full_name, 
                  against: ["first_name","last_name"],
                  using: { 
                    tsearch: { dictionary: :english } 
                  }

  def defaults
    self.build_contact_info.save
    self.build_birthday.save
    self.birthday.build_profile_date.save
    self.build_hometown.save
    self.hometown.build_address.save
    self.build_residence.save
    self.residence.build_address.save
  end
end

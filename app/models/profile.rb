class Profile < ActiveRecord::Base
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
end

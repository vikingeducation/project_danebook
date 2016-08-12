class Profile < ActiveRecord::Base
  after_create :defaults

  belongs_to :user
  has_one :birthday, dependent: :destroy
  has_one :contact_info, dependent: :destroy
  has_one :hometown, dependent: :destroy
  has_one :residence, dependent: :destroy

  [:birthday, :contact_info, :hometown, :residence].each do |child|
    accepts_nested_attributes_for child
  end

  validates :first_name, :last_name, { presence: true, 
                                       length: { in: 1..255 } }


  #pg_search
  include PgSearch
  #Defining a pg search scope
  pg_search_scope :search_by_full_name, 
                  against: ["first_name","last_name"],
                  using: { 
                    tsearch: { dictionary: :english } 
                  }

  private
    def defaults
      create_contact_info!
      create_birthday!
      create_hometown!
      hometown.create_address!
      create_residence!
      residence.create_address!
    end
end

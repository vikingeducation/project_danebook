class Profile < ApplicationRecord

  validates :first_name, 
            :length => { :in => 1..40 }

  validates :last_name, 
            :length => { :in => 1..40 }

  belongs_to :user

  def name
    first_name + " " + last_name
  end

  def remove_photo(id)
    if profile_photo_id == id
      profile_photo_id = nil
    elsif cover_id == id
      cover_id = nil
    end
  end

  def self.search(query)
    results = self.where("")
    if query
      query.each do |col, name|
        results = results.where("#{col} ILIKE ?", "%#{name}%") if name.present?
      end
    end
    results
  end

end

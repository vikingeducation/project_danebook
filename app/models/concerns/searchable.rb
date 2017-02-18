module Searchable

  extend ActiveSupport::Concern

  module ClassMethods

    def user_search(query)
      if query
        # returns an ActiveRecord relation
        where("first_name ILIKE ? OR last_name ILIKE ?", "%#{query}%", "%#{query}%")
      else
        where("")
      end
    end
    
  end

end
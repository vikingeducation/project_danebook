module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    def search(query)
      if query && query.include?(" ")
        queries = query.split(" ")
        where("first_name LIKE ?", "%#{queries[0]}%")
        where("last_name LIKE ?", "%#{queries[1]}%")
      elsif query
        where("first_name LIKE ?", "%#{query}%")
        where("last_name LIKE ?", "%#{query}%")
      else
        where("")
      end
    end
  end



end
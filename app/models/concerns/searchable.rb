# app/models/concerns/searchable.rb
module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    # Now we don't need to call it `self.search`
    # because it's destined to be a class method anyway
    def search(query_hash)
      results = self.where("")
      if query_hash
        query_hash.each do |col, term|
          # Parameterize that user input!!!
          # We've already whitelisted the columns in the controller
          results = results.where("#{col} LIKE ?","%#{term}%") if term.present?
        end
      end
      results
    end
  end
end
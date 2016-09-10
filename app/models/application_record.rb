class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def has_comments?
    self.comments.empty? ? false : true
  end
end

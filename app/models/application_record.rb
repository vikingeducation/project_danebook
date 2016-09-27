class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def has_comments?
    self.comments.empty? ? false : true
  end

  def sequenced_comments
    self.comments.order("created_at")
  end
end

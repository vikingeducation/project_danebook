require 'active_support/concern'

module Reusable
  extend ActiveSupport::Concern

  def date
    self.created_at.strftime('%A, %d %B %Y') if self.created_at
  end

end

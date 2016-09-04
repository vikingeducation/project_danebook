require 'active_support/concern'

module Likeable
  extend ActiveSupport::Concern

  included do
    has_many :likes, :as => :likeable, dependent: :destroy
  end

  class_methods do
  end
  
end

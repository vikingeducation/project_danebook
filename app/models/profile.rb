class Profile < ApplicationRecord
  belongs_to :user, inverse_of: :profile
  before_save :format_input

  enum gender_type: [:Male, :Female]

  validates_presence_of :first_name, :last_name, :birthday, :gender
  validates_format_of :phone, with: /\A(?=.*\d)[0-9- +]+\Z/, allow_nil: true
  validates :phone, length: { minimum: 4, maximum: 30 }, allow_nil: true

  def self.genders
    gender_types.keys.to_a.map{|v| [v.humanize, v.to_s.classify]}
  end

  private
    def format_input
      first_name.capitalize! if first_name
      last_name.capitalize! if last_name
    end

end

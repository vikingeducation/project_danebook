class Birthday < ActiveRecord::Base
  belongs_to :profile

  validate :reasonable_date

  private

    def reasonable_date
      date_object < 18.years.ago
    end
end

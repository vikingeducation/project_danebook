class Birthday < ActiveRecord::Base
  belongs_to :profile

  validate :reasonable_date

  private

    def reasonable_date
      if date_object > 18.years.ago
        errors.add :date_object, "Must be at least 18 years old to register."
      end
    end
end

class CreateProfileDates < ActiveRecord::Migration
  def change
    create_table :profile_dates do |t|
      t.references :dateable, index: true, polymorphic: true

      t.timestamps null: false
    end
  end
end

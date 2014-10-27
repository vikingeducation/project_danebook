class AddSchoolToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :school, :string
  end
end

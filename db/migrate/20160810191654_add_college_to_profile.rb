class AddCollegeToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :college, :string
  end
end

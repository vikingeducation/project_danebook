class AddCollegeAndTelephoneToProfile < ActiveRecord::Migration
  def change
  	add_column :profiles, :college, :string
  	add_column :profiles, :telephone, :string
  end
end

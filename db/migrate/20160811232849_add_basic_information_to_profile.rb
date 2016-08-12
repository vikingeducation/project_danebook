class AddBasicInformationToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :college, :string, optional: true
    add_column :profiles, :home_town, :string, optional: true
    add_column :profiles, :currently_lives, :string, optional: true
    add_column :profiles, :phone_number, :string, optional: true
  end
end

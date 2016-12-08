class Expandingprofile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :college, :string, :null => false, :default => " "
    add_column :profiles, :hometown, :string, :null => false, :default => " "
    add_column :profiles, :residence, :string, :null => false, :default => " "
    add_column :profiles, :telephone, :string, :null => false, :default => " "

    add_column :profiles, :summary, :text, :null => false, :default => " "
    add_column :profiles, :about_me, :text, :null => false, :default => " "
  end
end

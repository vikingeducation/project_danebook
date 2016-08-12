class AddMoreInfoToProfile < ActiveRecord::Migration[5.0]
  def change

    add_column :profiles, :hometown, :string, default: ""
    add_column :profiles, :current_residence, :string, default: ""
    add_column :profiles, :telephone, :string, default: ""
    add_column :profiles, :words_to_live_by, :text, default: ""
    add_column :profiles, :about_me, :text, default: ""

  end
end

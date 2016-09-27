class ChangeAboutMeDefault < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :about_me, :text, default: "say somthing!", null: false
  end
end

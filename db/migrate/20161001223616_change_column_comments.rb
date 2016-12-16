class ChangeColumnComments < ActiveRecord::Migration[5.0]
  def change
    change_column :comments, :text, :text
  end
end

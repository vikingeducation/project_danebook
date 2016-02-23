class Addattachphotos < ActiveRecord::Migration
  def change
    add_attachment :photos, :avatar
    add_column :photos, :user_id, :integer
  end
end

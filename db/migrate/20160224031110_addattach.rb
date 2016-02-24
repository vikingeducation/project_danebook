class Addattach < ActiveRecord::Migration
  def change
    add_attachment :photos, :image
    add_column :photos, :author_id, :integer
  end
end

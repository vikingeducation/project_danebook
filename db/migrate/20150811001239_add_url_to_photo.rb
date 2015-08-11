class AddUrlToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :img_url, :string
  end
end

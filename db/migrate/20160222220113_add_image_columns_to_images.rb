class AddImageColumnsToImages < ActiveRecord::Migration
  def change
    add_attachment :images, :picture
  end
end

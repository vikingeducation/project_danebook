class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
    	t.belongs_to :user
    	t.belongs_to :likeable, polymorphic: true

      t.timestamps
    end
  end
end

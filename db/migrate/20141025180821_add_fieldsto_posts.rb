class AddFieldstoPosts < ActiveRecord::Migration
  def change

    change_table :posts do |t|
      t.belongs_to :user
      t.text :body
    end

  end
end

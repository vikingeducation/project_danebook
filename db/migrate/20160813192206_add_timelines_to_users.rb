class AddTimelinesToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :timeline, index: true, foreign_key: true
  end
end

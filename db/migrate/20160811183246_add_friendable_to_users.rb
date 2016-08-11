class AddFriendableToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :friendable, index: true, polymorphic: true
  end
end

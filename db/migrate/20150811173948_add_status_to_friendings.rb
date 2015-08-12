class AddStatusToFriendings < ActiveRecord::Migration
  def change 
    add_column :friendings, :status, :string, default: 'not_friends'

  end
end

class AddNoticeCounterToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :notice_count, :integer, default: 0
  end
end

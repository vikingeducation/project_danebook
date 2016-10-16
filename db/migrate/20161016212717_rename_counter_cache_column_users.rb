class RenameCounterCacheColumnUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column(:users, :friends_count, :friendships_count)
  end
end

class CreateFriendsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :friends_users do |t|
      t.references :user, foreign_key: true
      t.references :friend, references: :users

      t.timestamps
    end
  end
end

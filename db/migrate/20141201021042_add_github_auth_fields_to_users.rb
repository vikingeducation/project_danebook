class AddGithubAuthFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :github_uid, :string
    add_column :users, :github_provider, :string
    add_column :users, :github_token_expires, :datetime
    add_column :users, :github_token, :string
  end
end

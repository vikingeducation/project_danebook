class AddUserProfileInfo < ActiveRecord::Migration
  def change
    add_column :users, :gender, :string
    add_column :users, :birth_day, :integer
    add_column :users, :birth_month, :integer
    add_column :users, :birth_year, :integer
    add_column :users, :college, :string
    add_column :users, :domicile, :string
    add_column :users, :hometown, :string
    add_column :users, :phone, :string
    add_column :users, :my_words, :string
    add_column :users, :about_me, :text
  end
end

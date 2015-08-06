class SwitchUserAndProfileAttributes < ActiveRecord::Migration
  def change
    # add_column :users, :birthdate, :date
    # remove_column :users, :gender, :string
    add_column :profiles, :gender, :string
    # remove_column :profiles, :birthdate, :date
  end
end

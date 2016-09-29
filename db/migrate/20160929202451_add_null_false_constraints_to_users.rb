class AddNullFalseConstraintsToUsers < ActiveRecord::Migration[5.0]
  def change
    change_column_null(:users, :first_name, false)
    change_column_null(:users, :last_name, false)
    change_column_null(:users, :email, false)
    change_column_null(:users, :password_digest, false)
    change_column_null(:users, :birthday, false)
    change_column_null(:users, :gender_cd, false, 0)
  end
end

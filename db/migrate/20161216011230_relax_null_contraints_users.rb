class RelaxNullContraintsUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :birthday, :date, :null => true
    change_column :users, :gender_cd, :integer, :null => true
  end
end

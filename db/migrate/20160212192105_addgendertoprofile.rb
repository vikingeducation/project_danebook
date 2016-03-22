class Addgendertoprofile < ActiveRecord::Migration
  def change
    add_column :profiles, :gender, :string
  end
end

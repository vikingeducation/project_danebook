class DropYears < ActiveRecord::Migration
  def change
    drop_table :years
  end
end

class DropTablePostLiking < ActiveRecord::Migration
  def change
    drop_table :post_likings
    # raise ActiveRecord::IrreversibleMigration
  end
end

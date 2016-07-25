class DropTestingsTable < ActiveRecord::Migration
  def change
    def up
      drop_table :testings
    end

    def down
      raise ActiveRecord::IrreversibleMigration
    end
  end
end

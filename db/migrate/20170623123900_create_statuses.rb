class CreateStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :statuses do |t|
      t.string :message, null: false

      t.timestamps
    end

    add_index :statuses, :message
  end
end

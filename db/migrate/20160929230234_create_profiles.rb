class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :college
      t.string :hometown
      t.string :address
      t.string :phone
      t.text   :status
      t.text   :about

      t.integer :user_id
      t.timestamps
    end
  end
end

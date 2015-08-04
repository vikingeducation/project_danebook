class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string  :college
      t.string  :hometown
      t.string  :current_home
      t.string  :mobile
      t.text    :summary
      t.text    :about
      t.integer :user_id, null: false

      t.timestamps null: false
    end
  end
end

class CreateContactInfos < ActiveRecord::Migration
  def change
    create_table :contact_infos do |t|
      t.references :profile, index: true, foreign_key: true
      t.string :email
      t.string :phone

      t.timestamps null: false
    end
  end
end

class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :user_id
      t.string :description
      
      t.references :commentable, :polymorphic => true
      t.timestamps
    end
  end
end

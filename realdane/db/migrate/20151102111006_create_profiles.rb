class CreateProfiles < ActiveRecord::Migration
  #before_create :set_default_profile
  
  
  def change
    create_table :profiles do |t|
      
      #t.integer :user_id
      
      t.string :first_name
      t.string :last_name
      
      t.date :birthday
      t.string :gender
      
      t.string :tel_number #telephone number
      t.string :words_to_live_by #words to live by
      t.string :about_me #about me
      
      t.timestamps null: false
    end
  end
  
private
=begin
  def set_default_profile
    t.tel_number = "0000000000"
    t.words_to_live_by = "nothing has been written"
    t.about_me = "nothing has been written"
  end
=end
end

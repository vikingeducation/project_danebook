class User < ApplicationRecord
  has_secure_password

  validates :first_name,
            :last_name, 
            :email,
            :birth_date,
            :birth_month,
            :birth_year, 
            :password, 
            :presence => true

  validates :first_name, :last_name, :length => { :in => 1..50}

  validates :email, :format => { :with => /@/ }

  validates :birth_date, :inclusion => { :in => 1..31 }
  validates :birth_month, :inclusion => { :in => 1..12 }
  validates :birth_year, :inclusion => { :in => 1900..2017 }

  validates :password, :length => { :in => 6..30 }, 
                       :allow_nil => true
end


  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "birth_date"
    t.integer  "birth_month"
    t.integer  "birth_year"
    t.boolean  "gender"
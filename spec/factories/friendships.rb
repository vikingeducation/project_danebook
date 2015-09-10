FactoryGirl.define do
  factory :friendship do

  end

end

# ----------
# create_table "friendships", force: :cascade do |t|
#   t.integer  "initiator_id",                     null: false
#   t.integer  "acceptor_id",                      null: false
#   t.string   "status",       default: "Pending"
#   t.datetime "created_at",                       null: false
#   t.datetime "updated_at",                       null: false
# end
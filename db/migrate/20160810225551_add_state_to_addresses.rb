class AddStateToAddresses < ActiveRecord::Migration
  def change
    add_reference :addresses, :state, index: true, foreign_key: true
  end
end

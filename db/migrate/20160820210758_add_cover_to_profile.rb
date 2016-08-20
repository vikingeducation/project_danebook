class AddCoverToProfile < ActiveRecord::Migration
  def change
    add_attachment :profiles, :cover
  end
end

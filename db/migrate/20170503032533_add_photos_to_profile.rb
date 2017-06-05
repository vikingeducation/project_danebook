class AddPhotosToProfile < ActiveRecord::Migration[5.0]
  def change
    add_reference :profiles, :cover, references: :photos, index: true
    add_reference :profiles, :avatar, references: :photos, index: true
  end
end

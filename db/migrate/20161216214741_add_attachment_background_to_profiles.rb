class AddAttachmentBackgroundToProfiles < ActiveRecord::Migration
  def self.up
    change_table :profiles do |t|
      t.attachment :background
    end
  end

  def self.down
    remove_attachment :profiles, :background
  end
end

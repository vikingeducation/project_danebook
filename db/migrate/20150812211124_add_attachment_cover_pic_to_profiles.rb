class AddAttachmentCoverPicToProfiles < ActiveRecord::Migration
  def self.up
    change_table :profiles do |t|
      t.attachment :cover_pic
    end
  end

  def self.down
    remove_attachment :profiles, :cover_pic
  end
end

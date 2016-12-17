class Notice < ApplicationRecord
  after_create :up_count
  before_destroy :destroy_count
  after_save :check_count

  belongs_to :user

  private
    def up_count
      count = user.notice_count + 1
      self.user.update_attribute(:notice_count, count)
    end

    def down_count
      count = user.notice_count - 1
      self.user.update_attribute(:notice_count, count)
    end

    def destroy_count
      unless self.viewed
        down_count
      end
    end

    def check_count
      if self.changes[:viewed] == [false, true]
        down_count
      elsif self.changes[:viewed] == [true, false]
        up_count
      end
    end
end

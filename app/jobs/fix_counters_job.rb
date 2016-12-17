class FixCountersJob < ApplicationJob
  queue_as :low_priority

  def perform(*args)
    # Do something later
    # User.all.each do |user|
    #
    # end
    ActiveRecord::Base.connection.execute <<-SQL.squish
    UPDATE users
    SET notice_count = (SELECT count(1)
                        FROM notices
                        WHERE (notices.user_id = users.id) AND notices.viewed = false)
    SQL
    ActiveRecord::Base.connection.execute <<-SQL.squish
    UPDATE posts
    SET likes_count = (SELECT count(1)
                       FROM likes
                       WHERE likes.post_id = posts.id),
        comments_count = (SELECT count(1)
                          FROM posts
                          WHERE posts.post_id = posts.id)
    SQL
  end

  after_perform do
    FixCountersJob.set(wait: 60.minutes).perform_later
  end
end

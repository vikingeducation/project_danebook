class Newsfeed
  def self.gather_posts(user)
    Post.all.where(author: user.self_and_friends).order(created_at: :desc)
  end
end

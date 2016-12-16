module UsersHelper
  def render_new_post(user, post)
    if user == current_user || !user
      render partial: 'shared/forms/new_post', locals: {user: current_user, post: post}
    end
  end

  def render_posts(posts)
    if posts.length > 0
      posts.each do |post|
        render partial: 'shared/posts/post', locals: { user: post.user, post: post, size: "small"}
      end
    else
      '<br><h2 class="text-center">No posts to show</h2>'.html_safe
    end
  end
end

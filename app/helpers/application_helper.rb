module ApplicationHelper
  def render_nav_content
    if signed_in_user?
      render_user_nav
    else
      render_login_nav
    end
  end

  def render_user_nav
    render partial: 'shared/search_bar'
    render partial: 'shared/navbar/user'
  end

  def render_like(post)
    if post.liked_user_ids.include?(current_user.id)
      link_to "Unlike", like_path(post), method: :delete
    else
      link_to "Like", like_path(post), method: :put
    end
  end

  def render_login_nav
    render partial: 'shared/navbar/anon'
  end

  def render_post_comments(post)
    comments = post.comments.select{|com| com.user }
    if comments.length > 0
      render partial: 'shared/posts/comments', locals: { comments: comments}
    end
  end

  def format_user_name(user)
     "#{user.profile.first_name} #{user.profile.last_name}"
  end
end

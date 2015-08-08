module PostsHelper

  def post_owner_link_option(post)

    if current_user.id == post.user_id
        link_to "Delete", user_post_path(current_user, post), method: :delete, class: "col-xs-1 col-xs-offset-6", data: { confirm: "Are you sure?" }
    end
  end

  def post_form_display
    render 'new_post_form' if current_user.id==params[:user_id].to_i
  end
end

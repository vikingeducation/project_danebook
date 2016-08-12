class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

    def require_login
      unless signed_in_user?
        flash[:error] = "You need to sign in to view this"
        redirect_to login_path #< if we've defined a custom login path
      end
    end

    def sign_in(user)
      user.regenerate_auth_token
      cookies[:auth_token] = user.auth_token
      @current_user = user
    end

    def permanent_sign_in(user)
      user.regenerate_auth_token
      cookies.permanent[:auth_token] = user.auth_token
      @current_user = user
    end

    def sign_out
      @current_user = nil
      cookies.delete(:auth_token)
    end

    def current_user
      @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
    end
    helper_method :current_user

    def signed_in_user?
      !!current_user
    end
    helper_method :signed_in_user?

    def user_liked?(post)
      !!(Like.where("likeable_type = 'Post' AND likeable_id = ? AND user_id = ?", post.id, current_user.id))
    end
    helper_method :user_liked?

    def post_liker(post)
      Like.joins("JOIN users ON user_id = users.id").
        where("likeable_type = 'Post' AND likeable_id = ? AND user_id != ?", post.id, current_user.id).limit(1).
        pluck(:first_name, :last_name)
    end
    helper_method :post_liker

    def user_liked_id(post)
      Like.where("likeable_type = 'Post' AND likeable_id = ? AND user_id = ?", post.id, current_user.id).pluck(:id)
    end
    helper_method :user_liked_id

    def post_likers(post)
      Like.joins("JOIN users ON user_id = users.id").
        where("likeable_type = 'Post' AND likeable_id = ? AND user_id != ?", post.id, current_user.id).count
    end
    helper_method :post_likers
end

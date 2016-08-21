module StaticPagesHelper

  def menu_options_class(action)
    page = content_for(:page).strip
    if action_name == 'about_edit' && action == 'about'
      'btn btn-default menu-option grey-background'
    elsif action.to_s == page
      'btn btn-default menu-option grey-background'
    else
      'btn btn-default menu-option'
    end
  end

  def get_header_path
    signed_in_user? ? 'layouts/loggedin_header' : 'layouts/login_header'
  end

  def needs_header?
    if controller.class == PhotosController
      return false if action_name == 'new'
      return false if action_name == 'show'
    end
    true
  end

  def construct_like_sentence(likes)
    num = likes.count
    users = likes.map(&:user)
    if num == 1 && likes.first.user == current_user
      'You like this'
    elsif num == 1
      '1 person likes this'
    elsif users.include?(current_user)
      "You and #{num - 1} others like this"
    else
      "#{users.first.profile.name} and #{num} other people like this"
    end
  end

  def friend_or_unfriend_button
    if current_user && current_user != @user
      if current_user.friends_with?(@user)
        unfriend_button
      else
        friend_button
      end
    end
  end

  def friend_button
    content_tag(:div, link_to("Friend", friendings_path(friending: {friendee: @user.id}), method: :post, type: 'button', class: 'btn btn-primary col-xs-offset-1', id: 'friend-button'), id: 'friend-button-container')
  end


  def unfriend_button
    content_tag(:div, link_to("Unfriend", friending_path(@user.id), method: :delete, type: 'button', class: 'btn btn-danger col-xs-offset-1', id: 'unfriend-button'), id: 'friend-button-container')
  end

  def first_half_of(arr)
    mid = arr.length / 2
    arr[0..mid]
  end

  def second_half_of(arr)
    mid = arr.length / 2
    arr[(mid + 1)..-1]
  end

  def home_button_path
    current_user ? link_to_timeline : link_to_sign_up
  end

  def link_to_sign_up
    new_user_path
  end

  def link_to_timeline
    user_timeline_path(current_user)
  end
end

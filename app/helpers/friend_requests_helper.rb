module FriendRequestsHelper
  def accept_friend_request_link(friend_request)
    accept_friend_request_form(friend_request, :class => 'text-success')
  end

  def accept_friend_request_button(friend_request)
    accept_friend_request_form(friend_request, :class => 'btn btn-success')
  end

  def reject_friend_request_link(friend_request)
    reject_friend_request_form(friend_request, :class => 'text-danger')
  end

  def reject_friend_request_button(friend_request)
    reject_friend_request_form(friend_request, :class => 'btn btn-danger')
  end

  def cancel_friend_request_link(friend_request)
    cancel_friend_request_form(friend_request, :class => 'text-danger')
  end

  def cancel_friend_request_button(friend_request)
    cancel_friend_request_form(friend_request, :class => 'btn btn-danger')
  end

  def send_friend_request_link(friend_request)
    send_friend_request_form(friend_request, :class => 'text-primary')
  end

  def send_friend_request_button(friend_request)
    send_friend_request_form(friend_request, :class => 'btn btn-primary')
  end

  def accept_friend_request_form(friend_request, options={})
    options[:method] = :put
    friend_request_form('Accept Friendship', friend_request, options)
  end

  def reject_friend_request_form(friend_request, options={})
    options[:method] = :delete
    friend_request_form('Reject Friendship', friend_request, options)
  end

  def cancel_friend_request_form(friend_request, options={})
    options[:method] = :delete
    friend_request_form('Cancel Friend Request', friend_request, options)
  end

  def send_friend_request_form(friend_request, options={})
    options[:method] = :post
    friend_request_form('+ Add Friend', friend_request, options)
  end

  def friend_request_form(text, friend_request, options={})
    query_string_params = {
      :user_id => current_user.id,
      :initiator_id => friend_request.initiator_id,
      :approver_id => friend_request.approver_id
    }
    if friend_request.persisted?
      path = friend_request_path(friend_request, query_string_params)
    else
      path = friend_requests_path(query_string_params)
    end
    link_to(text, path, options)
  end
end




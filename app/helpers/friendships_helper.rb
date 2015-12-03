module FriendshipsHelper
  def unfriend_link(friendship)
    unfriend_form(friendship, :class => 'text-danger')
  end

  def unfriend_button(friendship)
    unfriend_form(friendship, :class => 'btn btn-danger')
  end

  def unfriend_form(friendship, options={})
    options[:method] = :delete
    friendship_form('- Unfriend', friendship, options)
  end

  def friendship_form(text, friendship, options={})
    link_to(text, friendship_path(
      friendship,
      :user_id => current_user.id,
      :initiator_id => friendship.initiator_id,
      :approver_id => friendship.approver_id
    ), options)
  end

  def friend_form_for(user, options={})
    type = options[:type]
    friendable = current_user.friendship_with(user)
    resource_name = friendable.class.name.underscore
    partial = "#{resource_name.pluralize}/form"
    locals = {:user => user, :type => type}
    locals[resource_name.to_sym] = friendable
    render :partial => partial, :locals => locals
  end
end

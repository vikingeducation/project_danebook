module ApplicationHelper

  def form_error(resource, field)
    unless resource.errors[field].empty?
      html = '<span class="text-danger">' + resource.errors[field].first.capitalize + '</span>'
      html.html_safe
    end
  end

  def form_error_class(resource, field)
    'has-error' unless resource.errors[field].empty?
  end

  def flash_class(flash_type)
    case flash_type
    when 'success' then 'alert-success'
    when 'error', 'alert' then 'alert-danger'
    when 'notice' then 'alert-info'
    else
      flash_type.to_s
    end
  end

  private


  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def is_self?
    return false unless @user
    user_signed_in? && @user.id == current_user.id
  end


end

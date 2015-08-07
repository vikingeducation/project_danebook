module ApplicationHelper

  def bootstrap_class_for(flash_type)
    case flash_type
    when "success"
      "alert-success"
    when "error"
      "alert-danger"
    when "alert"
      "alert-warning"
    when "notice"
      "alert-info"
    else
      flash_type.to_s
    end
  end

  def navbar_display

    if signed_in_user?
      render partial: "shared/signed_in_navbar"
    else
      render partial: "shared/signed_out_navbar"
    end
  end

end

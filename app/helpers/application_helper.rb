module ApplicationHelper

  def date_wrap_open
   '<div class="col-xs-4"><div class="form-group">'.html_safe
  end

  def date_wrap_close
    '</div></div>'.html_safe
  end

  def date_separator 
    "#{date_wrap_close}#{date_wrap_open}"
  end

end

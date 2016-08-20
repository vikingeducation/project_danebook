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


  def before_photo(idx) 
    if idx%4==0
      '<div class="row">'.html_safe
    end
  end

  def after_photo(idx, photos)
    if (idx-3)%4==0
      '</div>'.html_safe
    elsif 
      idx == photos.count-1
      '</div>'.html_safe
    end
  end

end

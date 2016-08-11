class StaticPagesController < ApplicationController

  def home
    @header_path = 'layouts/login_header'
  end

  def timeline
    @header_path = 'layouts/loggedin_header'
  end

  def friends
    @header_path = 'layouts/loggedin_header'
  end

  def about
    @header_path = 'layouts/loggedin_header'
  end

  def photos
    @header_path = 'layouts/loggedin_header'
  end

  def about_edit
    @header_path = 'layouts/loggedin_header'
  end
end

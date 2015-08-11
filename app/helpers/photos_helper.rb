module PhotosHelper

  def photo_num
    num = User.find(params[:user_id]).photos.size
    num > 0 ? "(#{num.to_s})"  : ""
  end
end

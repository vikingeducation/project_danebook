class PhotoAssignment

  def initialize(user_id:, photo_id:, photo_type:)
    @photo_id = photo_id
    @user = User.find(user_id)
    @photo_type = photo_type
    assign_photo
  end

  def assign_photo
    if @photo_type == 'profile_pic'
      @user.profile_pic_id = @photo_id
    else
      @user.cover_pic_id = @photo_id
    end
    @user.save!
  end

end

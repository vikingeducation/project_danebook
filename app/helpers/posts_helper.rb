module PostsHelper
  def profile_helper(field)
    if field && !field.blank?
      field
    else
      "This user has not yet added this information!"
    end
  end
end

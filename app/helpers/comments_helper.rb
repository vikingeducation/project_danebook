module CommentsHelper

def commenter_name(parent_id)
	User.find(parent_id).name
end

end

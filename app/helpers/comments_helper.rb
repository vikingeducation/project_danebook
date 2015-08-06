module CommentsHelper

def like_count_to_display(comment)
	count = comment.count_likes
	if count > 1
		"#{count} people like this post" 
	elsif count == 1 
		"#{count} person likes this post"
	end
end

end

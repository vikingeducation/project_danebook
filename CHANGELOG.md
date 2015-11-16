# CHANGELOG

## (Uncommited)

- Create separate layout with profile header

## ee89b3d

- Users can now like posts and comments
- Liking is only allowed for the current user
- Unliking is only allowed if the unlike is submitted by the current user
- There is logic in place to display grammatically sensible english for likes on likeables
- First few users who liked a likeable are displayed with links to their timeline
- A users index exists for development purposes
- Add posts, comments, and likes to `seeds.rb`

## 9e04ac8

- Move post markup to `posts/post` partial
- Enable comment creation on posts
- Perform authorization checks for comment create/destroy
- Create commentable polymorphic relationship with posts

## 3038988

- Added posts resource
- Added user timeline partial
- Currently logged in user may create and delete only posts belonging to that user
- Timeline is restricted to logged in user

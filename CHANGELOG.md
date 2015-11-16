# CHANGELOG

## (Uncommited)
- Move post markup to `posts/post` partial
- Enable comment creation on posts
- Perform authorization checks for comment create/destroy
- Create commentable polymorphic relationship with posts

## 3038988

- Added posts resource
- Added user timeline partial
- Currently logged in user may create and delete only posts belonging to that user
- Timeline is restricted to logged in user

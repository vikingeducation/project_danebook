===========
Model Specs
===========

15-30 specs
what is most likely to break / the worst thing to have break?

users: 
- user not created with an invalid password
- user not created with a duplicate email address
- generate_token gets called before user create
- generate_token creates a different token
- regenerate_auth_token invalidates old token
- regenerate_auth_token creates a different new token
- creating a new user creates a new profile too
- deleting a user deletes their profile too


friending:
- can't create the exact same friendship
- can't have the same friend_id and friender_id
- has a friend initiator
- has a friend recipient


post:
- can't create a post without a user_id
- can't create a post without a body
- can't create a post with a super-long body
- comments are deleted when a post is deleted
- likes are deleted when a post is deleted


like: 
- can't be created without a user_id
- can be created on a post
- can be created on a comment
- can't create multiple likes on the same post by the same user
- can't create multiple likes on the same comment by the same user


comment:
"can't create a comment without a body"
"can't create a comment with a super-long body"
"likes are deleted when a comment is deleted"


==============
Feature Specs
==============

visitor:
"sign up works with valid credentials"
"sign up does not work with invalid credentials"
"cannot access timeline"
"cannot access profile"
"cannot access friendings"

existing user:
"can log in with valid credentials"
"cannot log in with invalid credentials"


profile:
"logged in user can edit their profile"
"invalid profile attributes are rejected"


posts:
"are sorted in descending chronological order"
"logged in user can create a post"
"logged in user can delete a post"
"logged in user cannot delete a post they didn't write"
 

comments: - WIP
"logged in user can create a comment on their own post"
"logged in user can create a comment on another user's post"
"logged in user can delete a comment"
"logged in user cannot delete a comment they didn't write"


likes:
"logged in user can like a post"
"logged in user can like a comment"



friendings:
"logged in user can add a new friend"
"logged in user can unfriend an existing friend"


==================
Controller Specs
==================
friendings:
"POST#create cannot friend someone more than once"
"POST#create can add friend to friended_users"
"DELETE#destroy removes friend but doesn't delete user"


posts:
"GET#index sets the correct instance variables"


profiles:
"PUT#update sets a flash message"


sessions:
"POST#create calls permanent_sign_in for remember me"
"DELETE#destroy redirects to root path with flash message" 
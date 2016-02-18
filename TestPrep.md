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

logged in user:
"can log in with valid credentials"
"cannot log in with invalid credentials"
"can edit their profile"
"invalid profile attributes are rejected"
"can create a post"
"can delete a post"
"cannot delete a post they didn't write"
"can like a post"
"can like a comment"
"cannot delete a comment they didn't write"



posts:
"are sorted in descending chronological order"


friendings:
"logged in user can add a new friend"
"logged in user can unfriend an existing friend"
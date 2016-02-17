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


post:
- can't create a post without a user_id
- comments are deleted when a post is deleted
- likes are deleted when a post is deleted


like: 
- belongs to user
- can be created on a post
- can be created on a comment


comment:
- belongs to a post and a user

danebook
========

This is the Real Dane Deal.
=======


Julia Herron


Heroku url: https://floating-hollows-92101.herokuapp.com/


=======
ASSOCIATIONS
=======

user has ONE profile, created after a new user is created
user has MANY posts, post belongs_to ONE user
"timeline" is just the name for the 'posts#index' route


=======
likes are polymorphic: can like a post, or a comment, etc.
post has MANY likes, like belongs_to ONE post
comment has MANY likes, like belongs_to ONE post
posts and comments are "likeable"

likes table will look like this:
id | user_id | likeable_id | likeable_type | created_at

when a post is deleted, the likes and comments should be destroyed


=======
post has_many comments
user has_many comments
comment belongs_to post
comment can have many likes

when a comment is deleted, the likes should be destroyed

=======
FRIENDING
(if one person clicks "Add Friend", it creates the friendship)
self-referencing many-many relationship

create join table called friendings, plus Friending model
- foreign keys are "friender_id" and "friend_id"
- in Friending.rb, "belongs_to :friend_initiator"
- in User, "has_many :initiated_friendings" to get to join table, and "has_many_friended_users" through the join table

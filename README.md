
danebook
========

This is the Real Dane Deal.
=======


Julia Herron


Heroku url: https://floating-hollows-92101.herokuapp.com/



ASSOCIATIONS

user has ONE profile, created after a new user is created

"timeline" is just the name for the 'posts#index' route

user has MANY posts, post belongs_to ONE user

likes are polymorphic: can like a post, or a comment, etc.
post has MANY likes, like belongs_to ONE post
comment has MANY likes, like belongs_to ONE post

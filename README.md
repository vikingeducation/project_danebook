danebook
========

This is the Real Dane Deal.
=======
# assignment_danebook_pages

[An HTML5, CSS3, Bootstrap, and SASS project of the Viking Code School](http://www.vikingcodeschool.com)

Felipe Suero
Dexter Ford

Views:
  user index = all yr friends
  user show = your "wall"/timeline
  user edit = account info edit
  user new = sign up / sign in

  profile edit = about edit
  profile show = about page

  post index
  post show = one post details w/ comments
  post new = create post
  post edit = edit post

Models:
User
  first_name
  last_name
  email
  password_digest
  has one profile_id
  has many likes

Profile
  has one user_id
  birthday
  home city
  etc etc etc, migrate more as needed

Posts
  belongs to one user
  has many likes
  has a body

Likes
  has one user 
  has one post

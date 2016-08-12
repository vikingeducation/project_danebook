danebook
========

Alex Lach's Danebook

This is the Real Dane Deal.

User
- has many posts_written
- has many posts_received
- has many comments_written
- has many likes_given

Post
- belongs_to :postable, :polymorphic =>
- belongs_to user
- has_one receiving_user
- has_many comments
- has_many likes

Comment
-has_one parent (polymorphic for comment or post)
-has_many comments
-has_many likes

Likes
- belongs_to user
- belongs_to likeable (polymorphic for posts and comments)

PostText
- has_one :post, :as => :postable

Photo
- has_one :post, :as => :postable

Video
- has_one :post, :as => :postable

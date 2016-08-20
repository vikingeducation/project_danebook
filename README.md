Danebook


[DEMO](danebook-app.herokuapp.com)


=====

A Facebook clone built using Ruby on Rails. It is an application of the MVC pattern and RESTful development principles, with some non-RESTful resources here and there. The technologies used include:


(1) Postgresql for the database


(2) PG Search to take advantage of Postgresql's full-text search feature


(3) DelayedJobActiveRecord as an adapter for ActiveJobs


... and much, much more.


### ENTITY RELATIONSHIP MODEL ###


The pertinent resources can be summarized as follows:


(1) users


(2) profiles


(3) posts


(4) comments


(5) photos


(6) posts


(7) likes


(8) timelines


The User is what one would normally expect it be: a container for account information such as login credentials and a visual identifier, i.e. the avatar. Public information such as the current residence and phone number are delegated to the Profile.


Common social network activities such as posts, comments, and likes each point to the author thereof. A User can make a Post, make a Comment to a Post, and like either of the two. This was made possible by utilizing ActiveRecord's polymorphic relationships. For example, the polymorphic identifier 'commentable' allows the Comment to point to any other resource without having to know what that resource is. The same is true with the Like and the 'likeable' identifier. So a Comment can belong to a Post that is designated as a 'commentable' resource: it is something that can be commented on. Likewise, a comment can also belong to another comment marked as a 'commentable': the target comment is something that can be commented on, as well. A like can belong to a Post or a Comment; it really doesn't matter which it is referring to since they're both designated with the 'likeable' identifier.

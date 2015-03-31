Danebook!!!!!
==========

This is the official solution repo for Viking Code School's complete social media app demo, Danebook.

If you're reading this, you have learned enough Rails to be dangerous as a developer, built and rebuilt database schemas, worked with professional test-driven development workflows, negotiated with strange APIs, fought Bootstrap and made it do your bidding, and created a working social media web app that leaves one-dimensional online tutorials in the dust. Build this, and you'll eventually be able to build anything.

This app completes all Pivotal Tracker stories required for a complete Danebook, as well as several optional features such as reciprocal friendships that require friend request acceptance, Oauth 2.0 sign-in through Github, AJAX-enabled forms, and additional test coverage.

Below, this README will cover A) How it was done, B) Some cool bonus features, C) Some notes on testing coverage.

Currently live at [this Heroku address](http://danebooking.herokuapp.com).

*NOTE: As always, this solution repo is not to be shared outside of Viking Code School.*

## How It Was Done

This section walks through all of the major sections of this app in order to explain the design decisions made in their creation.


### The Schema

**Users** are the core of this app, the table from which so many other relations flow. In Danebook, a User object is host to name, email, and login information(whether in-app via `has_secure_password` and cookie-based auth token, or via OAuth), as well as holding the `profile_photo_id` and `cover_photo_id` that allow that user to choose specific images for their cover page via `has_one` relationship.

**Profiles** exist as a repository for the personal data of a User: birthday, location, contact information, favorite quotations. A User `has_one` Profile. Since a User may be created and saved before its Profile exists, the foreign key exists on the Profile.

**Posts** are the second-most important table to the functionality of the app, but they are possibly the most simple. A User `has_many` Posts. A Post's only  field, aside froms `user_id` and timestamps, is the `body` that contains the text of the post.

**Likes**, one of the most popular forms of social media currency, are a first-class citizen represented by a polymorphic join table linking a `user_id` and `likable_id` with help from a `likable_type`. Liking a Post is actually just creating a Like object linking that user to that post, and unliking is simply destroying that Like. Since no user should be able to like the same thing twice, `user_id` is unique within the scope of a specific `likable_id` and `likable_type`.

**Comments** allow for dialogue on Posts and Photos. Because Comments already exist in two places but can easily be imagined to show up elsewhere, they are a table in a polymorphic association with Posts and Photos. A Photo has_many Comments, but a Post has_many Comments as well. This functionality is implemented via the Commentable association, which is described in more detail below. Users are *also* in a one-to-many relationship with Comments as their Author, but without polymorphism. In one way, a Comment can be seen as a join  table with a `body` text field attached. Unlike Likes, a User can comment on the same Post or Photo multiple times, so the intersection of Commentable ID and User ID is not unique.

**Photos** belong to Users and are otherwise built entirely in conformity with the [Paperclip gem's](https://github.com/thoughtbot/paperclip) required fields.


### The Routes

Almost all routes are nested under Users, since each User has their own Profile, their own Timeline, and their own collection of Photos, of Posts, and of Friend Requests and Friends. Comments and Likes are in turn nested under all possible Likable and Commentable resources in order to enable polymorphic routing. This app uses the style of passing an additional default parameter in order to distinguish parents of polymorphic routes, e.g.: `resources :comments, only: [:create, :destroy], :defaults => { :commentable => 'Post' }` for the comments routes nested under Posts.

Top-level routes aside from the User are the various Session routes that handle login and logout, the OAuth routes that also get passed to the Sessions controller, and the `/newsfeed` route. `/newsfeed` is a top-level route in order to prevent logging into multiple users' newsfeeds and seeing their friends' posts instead of one's own.


### The Models

**The User model is the most complex model in the app**, with dozens of lines of associations, validations and callbacks around its complex relationships with other models and its login functionality. Model methods for login with Github using Omniauth live here, as well as methods to trigger a delayed-job welcome email. Search functionality lives here as well, since a single class method `User.search` handles all search queries. If search were any larger, it would be a serious candidate for its own module. Convenience methods like `user#likes?` exist in order to use a single method to determine a user's relationship with any piece of content in the app.

**The Profile model** has nearly no methods, but numerous validations in order to keep user personal data under control.

**The Post model** is even slimmer, but contains a class method, `.newsfeed_for(user)`, that returns all recent posts by a given User's friends. This is called by `user#newsfeed`, a wrapper method built to allow a single user to call for its own newsfeed.

**The Comment model** includes a method for comment notification that handles the polymorphic Commentable association. It parses the class of its parent object, finds that object's owner, then notifies the owner that a new comment has appeared. It has extra conditions to avoid notifying yourself that you are commenting on your own post.

**The Like model** is a simple polymorphic join table, but does offer an example of validating uniqueness within a scope:  `validates_uniqueness_of :user_id, scope: [:likable_id, :likable_type]`.

**The FriendRequest model and Friending model are separate** in order not to require complex queries every time a user queries for their friends. The additional space required is justified by the speedier load times, but other students may make this choice differently. As mentioned in the Schema section, `after_create` callbacks in the Friending model handle the maintenance of reciprocal friendships that destroy leftover FriendRequests when they come into being.


### The Controller

Most controller actions demonstrate simple CRUD functionality, aside from the polymorphic-enabled actions for CommentsController and LikesController (see below for more detail.)

One exception:

####Cookie-Based Auth via SessionsController

Login and logout are handled via a SessionsController that uses an `:auth_token` cookie to authenticate users. Users can check a 'remember me' box when logging in to request a permanent cookie that does not expire.

The SessionsController also handles OAuth login, currently only for sign-in via Github. It allows a user to sign in if they have *either* a valid OAuth token *or* supply the proper password.

Methods on the parent ApplicationController allow for all controllers and views to track the `current_user` and deny access where necessary, whether to anyone not signed in or to anyone who isn't the owner of the content in question.

### The View

A complex app like this one encompasses dozens upon dozens of views, partials and helper methods.

Rather than walk through every single one of them, here are a couple unusually complicated pieces of the puzzle:


####Conditional Button Helper Methods
In order to keep complicating logic out of the views, this app uses helper methods to handle buttons with conditions on their appearance.

For example, a single `friend_button` method takes a User as parameter and returns either the button to make a friend request, the button to cancel that request if it was already made, or the button to cancel the friendship if the reciprocal friendship already exists. It also returns a blank placeholder if the User is the `current_user`, in order to keep you from friending yourself.

A `like_link` for polymorphic Likes is similarly well-suited to a view helper method.


####Conditional Sentences

Another good candidate for such methods was the extremely complicated `like_sentence` method, which returns sentences like "You, Bob Bobson and 9 other users liked this Post." Since it needs to handle zero, one, two, and many users, with and without the current user included, and it also needs to handle case statements, it was far too complex to use a partial. A complex case statement with some introspection on the parent object was enough to produce a working `like_sentence` method. It is also thoroughly tested in Rspec under the View Tests section.


## Extra Features of Note


### Photo Uploading via Paperclip and Amazon S3
Profile photos can be uploaded to the site and served via Amazon S3 using the Paperclip gem.


###AJAX-enabled Comment and Post Forms

Using `remote: true` forms and custom `js.erb` files, Danebook uses Rails' built-in functionality to handle AJAX requests. New posts immediately slide down and appear on the existing timeline page, as do comments.


###Fully Polymorphic Likes and Comments

Both `Likes` and `Comments` can attach to Posts, Photos, or other Likable or Commentable objects via polymorphic associations. This app implements completely polymorphic routes and controllers for each of these models. A single `Likes#create` controller action can handle requests to `POST /users/4/posts/3/likes` and to `POST /users/4/photos/9/likes` to like Posts and Comments, respectively. Deletion (unliking and deleting comments) is similarly polymorphic.


###Reciprocal Friends

This app implements a reciprocal user friendship using callbacks and separate `FriendRequest` and `Friending` models. A User may create a Friend Request targeting another user, implemented via self-join table. That second User may then click the "Accept Friend Request" button, which uses `after_create` callbacks to destroy the existing friend request and create `Friending` objects for both directions of the friendship. This way, any friendship appears in queries on either foreign-key of the `Friendings` join table, and unfriended users do not appear as Friend Requests when someone is unfriended.


###Delayed-Job Emails
Uses the Delayed Job gem to send ActionMailer notification emails asynchronously using a worker queue. Emails implemented thus far are a signup welcome email and a notification for new comments on a user's posts and photos.

Email sending can be turned synchronous or asynchronous by setting the `ENV['DELAY_EMAILS']` environment variable to `true` or `false`.



##Testing

Test coverage using Rspec, FactoryGirl, Capybara and Poltergeist. This demo does not have test coverage for all code paths (*TODOS* include testing photo, email, and Github API functionality via properly-deployed mocks, as well as exhaustive integration testing of friend requests and reciprocal friendships), but it represents the full range of requirements of the assignment, as well as numerous optional tests beyond the strictly required.


###Model

Tests validations for all core models, as well as covering the vast majority of custom model methods. User model unit testing includes extensive tests of the `User.search` class method that provides search functionality for the app.


###Feature/Integration

Tests authentication, user creation, and the complete range of user timeline flows, including reading posts, posting, commenting and liking. Uses the Poltergeist gem to demo JavaScript web driving via PhantomJS.


###Controller

Uses controller tests instead of integration tests where possible in order to speed up runtimes. Full coverage of UsersController and PostsController, including all functionality for the Search feature. Strategically tests the `POST #create` route of the polymorphic Comments controller in order to demonstrate testing a polymorphic route that handles multiple types of parent object in a single controller action.


###View

Minimal usage of View testing, due to the limitations of this type of test. Nonetheless, `spec/views/post_spec.rb` contains an example of using view tests to document a complex conditional view helper method across a wide range of inputs. `spec/rails_helper.rb` also demonstrates the selective disabling of verifying doubles for view tests in order to allow stubbing auto-included `#current_user` controller helper methods onto the view object for testing purposes. [See this Github Issue for further info.](https://github.com/rspec/rspec-rails/issues/1076)




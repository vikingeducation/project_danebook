Danebook!
==========

This is the official solution repo for Viking Code School's complete social media app demo, Danebook.

If you're reading this, you have learned enough Rails to be dangerous as a developer, built and rebuilt database schemas, worked with professional test-driven development workflows, negotiated with strange APIs, fought Bootstrap and made it do your bidding, and created a working social media web app that leaves one-dimensional online tutorials in the dust.

This app completes all Pivotal Tracker stories required for a complete Danebook, as well as several optional features such as reciprocal friending, Oauth 2.0 sign-in through Github, AJAX-enabled forms, and additional test coverage.


## Features of Note

###Photo Uploading via Paperclip and Amazon S3
Profile photos can be uploaded to the site and served via Amazon S3.

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





Currently live at [this Heroku address](http://danebooking.herokuapp.com).
danebook
========

This is the Real Dane Deal. It's an imitation of Facebook.
You can see it here:

[lortzadanebook.herokuapp.com/](https://lortzadanebook.herokuapp.com/)

## Stats
- Rails 5.0.6
- DB: postgres 0.18
- Ruby: 2.4.2
- Repos:
  - Current codebase: [project_danebook](https://github.com/lortza/project_danebook)
  - Original markup: [assignment_danebook_goes_live](https://github.com/lortza/assignment_danebook_goes_live)
- Heroku is set up to auto-deploy when I push to GitHub master. FTW!
- Images hosted on AWS S3

## Features

- basic user authentication (hand-rolled)
- publish text posts & photos
- comment on and delete their own comments from text and photo posts
- like/unlike any post, photo, or comment
- friend/unfriend other users
- search for users
- add personal info to profile
- set profile pic and cover pic for profile
- see others' timelines
- see your own newsfeed
- granular user authorization policies
- suite of tests

# Tour of the App

Though you can [go here](https://lortzadanebook.herokuapp.com/) to sign up and see a working version of this app (delayed spin-up courtesy of free heroku dynos ;) ), here is an overview of the features.

Look! It's a timeline page for Clark "Mouth" Devereaux from the 80s classic movie _The Goonies_! And here he is having a comment thread about the Truffle Shuffle. Awww. So you get the drill. This app looks and acts like Facebook.

![Alt text](/app/assets/images/screenshots/timeline.jpg?raw=true "User Timeline Page")

It's got pages where you can update your profile info:
![Alt text](/app/assets/images/screenshots/profile_edit.png?raw=true "Profile Edit Page")

See your friend's photos:
![Alt text](/app/assets/images/screenshots/photos.png?raw=true "Photos index page")

Have admin options in the close-up modal for your photos:
![Alt text](/app/assets/images/screenshots/photos_index.png?raw=true "Photo management modal")

And, among other other features, see your list of friends:
![Alt text](/app/assets/images/screenshots/friends.jpg?raw=true "Friends Page")


## App Architecture
Now that we've got the basic functionality out of the way, let's get down to the interesting parts of the code that make this happen.

This app's architecture is a little complicated, with self-referencing `User`s table associations and some polymorphism with `Like`s and `Comment`s, and some user authorization rules.
![Alt text](/app/assets/images/screenshots/erd.png?raw=true "Schema ERD")

### Self-Referencing Users for Friending
Explanation WIP as of 3/7/2018

### Polymorphic Associations
Explanation WIP as of 3/7/2018
In the mean time, check out the [blog post I wrote](http://lortza.github.io/2018/01/30/polymorphic-likes.html) about it.

### User Authorization
Since there are a lot of little decision to be made about who gets to do what to what, I implemented user authorization with the help of `gem 'pundit'`. This keeps all of my policies organized and logical in one tidy spot:

```
/app
  /policies
    - application_policy.rb
    - comment_policy.rb
    - photo_policy.rb
    - post_policy.rb
    - user_policy.rb
```

For example, users are not permitted to post photos on another user's timeline, nor are they allowed to delete or edit another user's photo. The photo policy makes these rules very clear:

```ruby
# app/policies/photo_policy.rb

class PhotoPolicy < ApplicationPolicy

  def create?
    # allow only if the current_user on their own timeline
    record.user_id == user.id
  end

  def destroy?
    # allow only if the current_user is on their own timeline
    record.user_id == user.id
  end

  def edit?
    # allow only if the current_user is viewing their own photo
    record.user_id == user.id
  end
end
```

Writing the policy is half of the task. The other half is invoking it. Since the policies are conveniently named to match controller actions, the gem knows which policy to invoke when referenced in a controller:

```ruby
# app/controllers/photos_controller.rb

class PhotosController < ApplicationController
...

  def create
  ...
    photo = current_user.photos.new(photo_params)

    # checks if photo.user_id == user.id
    authorize photo

    if photo.save
    ...
```


### App Architecture Evaluation
The current codebase has a RubyCritic score of 93.84, which is nice while still has plenty of room for improvement.

![Alt text](/app/assets/images/screenshots/rubycritic.png?raw=true "RubyCritic stats")

According to the dots, my Rails app is made of to groups of files 1) the ones in the bottom left that are low in complexity and churn rate, and 2) the ones in the top center that are moderately complex and churn a moderate amount. It's [that second group](https://github.com/chad/turbulence#hopefully-meaningful-metrics), that I'll need to focus on first for refactoring.

The files in the second group, floating around up there in the high complexity region, are the controllers for the various activities that users do: posts, photo posts, comments, and likes. Some of that complexity comes from determining a parent class or object (in the case of likes and comments), some of it comes from features like sending a mailing or redirecting back to the page where the request was initiated.

For the logic that determines parents, I'm thinking about a model that may be able to handle these kinds of processes. As for the redirects, incorporating an AJAX call to handle the create/destroy actions for `like`s and `comment`s will take away the need for the redirect logic. And that's convenient, because that's on my to-do list for features.

The green dot on the far right is the `User` model. Given that users have their hands in every interaction and a good deal of those involve that self-referencing logic, I know the churn is going to stay high on this file. I'm thinking my best bet is to reduce the complexity of the file. At the moment, I don't have any great ideas on how to do that and I'd love to hear suggestions.



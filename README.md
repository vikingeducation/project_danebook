danebook
========

This is the Real Dane Deal. It's an imitation of Facebook. Awwww.
You can see it here:

[lortzadanebook.herokuapp.com/](https://lortzadanebook.herokuapp.com/)

## Stats
- Rails 5.0.6
- DB: postgres 0.18
- Ruby: 2.4.2
- Original repo for frontend: [assignment_danebook_goes_live](https://github.com/lortza/assignment_danebook_goes_live)
- Repo for eeeeverything else: [project_danebook](https://github.com/lortza/project_danebook)
- Heroku is set up to auto-deploy when I push to GitHub master. FTW!
- Images hosted on AWS S3

## Features

- basic user authorization (hand-rolled)
- publish text posts & photos
- comment on and delete their own comments from text and photo posts
- like/unlike any post, photo, or comment
- friend/unfriend other users
- search for users
- add personal info to profile
- set profile pic and cover pic for profile
- see others' timelines
- see your own newsfeed

# Tour of the App

Though you can [go here](https://lortzadanebook.herokuapp.com/) to sign up and see a working version of this app (delayed spin-up courtesy of free heroku dynos ;) ), here is an overview of the features.

Look! It's a timeline page for Clark "Mouth" Devereaux from the 80s classic movie _The Goonies_! And here he is having a comment thread about the Truffle Shuffle. Awww. So you get the drill. This app looks and acts like Facebook.

![Alt text](/app/assets/images/screenshots/timeline.jpg?raw=true "User Timeline Page")

It's got pages where you can update your profile info:
![Alt text](/app/assets/images/screenshots/profile_edit.png?raw=true "Profile Edit Page")

See all of your friends photos:
![Alt text](/app/assets/images/screenshots/photos_index.png?raw=true "Photos index page")

Have admin options if the photo is yours:
![Alt text](/app/assets/images/screenshots/photos_edit.png?raw=true "Photos closeup modal")

And, among other other features, see your list of friends:
![Alt text](/app/assets/images/screenshots/friends.jpg?raw=true "Friends Page")


## App Architecture
Now that we've got the basic functionality out of the way, let's get down to the interesting parts of the code that makes this happen.

This app's architecture is a little complicated, with self-referencing `User`s table associations and some polymorphism with `Like`s and `Comment`s available for use with `Post`s and `Photo`s. Thanks to [rails-erd](https://github.com/voormedia/rails-erd) for the sweet ERD gem that makes this image:
![Alt text](/app/assets/images/screenshots/erb.png?raw=true "Schema ERD")

### Self-Referencing Users for Friending
Explanation WIP as of 3/7/2018

### Plymorphic Associations
Explanation WIP as of 3/7/2018
In the mean time, check out the [blog post I wrote](http://lortza.github.io/2018/01/30/polymorphic-likes.html) about it.

### User Authorization
Explanation WIP as of 3/7/2018

### App Architecture Evaluation
The current codebase has a RubyCritic score of 93.84, which is nice and still has plenty of room for improvement.

![Alt text](/app/assets/images/screenshots/rubycritic.png?raw=true "RubyCritic stats")

According to the dots, my Rails app is made of simple files that don't churn often, and moderately complex files that churn a moderate amount. It's [that second group](https://github.com/chad/turbulence#hopefully-meaningful-metrics), in the upper region, that I'll need to focus on for refactoring.

The files floating around up there in the high complexity region are the controllers for the various activities that users do: posts, photo posts, comments, and likes. Some of that complexity comes from determining a parent class or object (in the case of likes and comments), some of it comes from features like sending a mailing or redirecting back to the page where the request was initiated.

For the logic that determines parents, I'm thinking about a model that may be able to handle these kinds of processes. As for the redirects, incorporating an AJAX call to handle the create/destroy actions for `like` and `comment` will take away the need for the redirect logic. And that's convenient, because that's on my to-do list for features.

The green dot on the far right is the `User` model. Given that users have their hands in every interaction and a good deal of those involve that self-referencing logic, I know the churn is going to stay high on this file. My best bet is to reduce the complexity of the file. At the moment, I don't have any great ideas on how to do that and I'd love to hear suggestions.



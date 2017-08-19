
# Project Danebook

Danebook is an web application, functionally similar to Facebook. This means users can securely signup and join the community, friend other users, upload their photos, post or comment others posts/photos. A user can also like others photos, comments or posts.

## About the author
[Dariusz Biskupski](https://github.com/Visiona/assignment_danebook_goes_live)

## Getting Started

Live version of the app available here:
[Deployed Danebook](https://enigmatic-earth-17108.herokuapp.com)


### Overview


![Signup page](https://github.com/Visiona/project_danebook/blob/master/public/assets/Danebook7.png)
**Sign Up to Danebook Social network. **
***

![Upload Photo Page](https://github.com/Visiona/project_danebook/blob/master/public/assets/Danebook1.png)
***Upload photos to your Danebook account. You can mark one as your profile prhoto or/wallpaper photo.  **
***

![View your photos](https://github.com/Visiona/project_danebook/blob/master/public/assets/Danebook4.png)
**Check your photo or photos of your friends. Like them, comment them or even like comments **
***

![See your friends or other users friends](https://github.com/Visiona/project_danebook/blob/master/public/assets/Danebook13.png)
**Check your friends of your or your friends if you click their name. Here you can also unfriend some of them if you changed your mind **
***

![Newsfeed](https://github.com/Visiona/project_danebook/blob/master/public/assets/Danebook12.png)
**Here you can see activity of your friends. You can check your posts and posts of your friends, comment them, like or unlike, and even see who liked them! **
***

![Edit your profile](https://github.com/Visiona/project_danebook/blob/master/public/assets/Danebook9.png)
**Here you can add of change about your profile **
***

![Timeline](https://github.com/Visiona/project_danebook/blob/master/public/assets/Danebook14.png)
**Here you see all your posts, comments - you can like any of other comments or comment them. Here is also small preview of your photos and friends.  **
***

![Search for friends](https://github.com/Visiona/project_danebook/blob/master/public/assets/Danebook5.png)
**Here you can search for other people who are on Dnebook. You can check basic info of people in search results and friend or unfriend them.**
***

### Installing

To get the app started locally you'll need to:

1. Clone the repo with `git clone REPO_URL`
1. `cd` into the project
1. Run
  - `$ bundle install`
  - `$ bundle exec rake db:migrate`
  - `$ bundle exec rake db:seed`
1. Start up the server with `rails s` command and visit `http://localhost:3000` in your browser

## Running the tests

A big part of the functionality is covered by rspec tests which can be run with following command:
```
bundle exec rspec
```

## Acknowledgments

* I would like to thank to The Viking Code School for big help in advancing with this application, as well as to my mentor Holman Gao who shared his experience in the most challenging stages of the project. Last, but not the least - big thank you to [https://stackoverflow.com](https://enigmatic-earth-17108.herokuapp.com).

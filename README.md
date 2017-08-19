
# Project Danebook

Danebook is an web application, functionally similar to Facebook. This means users can securely signup and join the community, friend other users, upload their photos, post or comment others posts/photos. A user can also like others photos, comments or posts.

## About the author
[Dariusz Biskupski](https://github.com/Visiona/assignment_danebook_goes_live)

## Getting Started

[Danebook deployed on Heroku](https://enigmatic-earth-17108.herokuapp.com)

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Overview

![Signup page](https://github.com/visiona/project_danebook/public/assets/Danebook7.png  | width=400)


![Upload Photo Page](https://github.com/visiona/project_danebook/public/assets/Danebook1.png  | width=400)

![View your photos](https://github.com/visiona/project_danebook/public/assets/Danebook4.png  | width=400)

![See your friends other users](https://github.com/visiona/project_danebook/public/assets/Danebook13.png  | width=400)

![Newsfeed](https://github.com/visiona/project_danebook/public/assets/Danebook12.png  | width=400)

![Edit your profile](https://github.com/visiona/project_danebook/public/assets/Danebook9.png  | width=400)

![Timeline](https://github.com/visiona/project_danebook/public/assets/Danebook14.png  | width=400)


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

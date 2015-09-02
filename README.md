[The Danebook][1]
============
Rails Project from [Viking Code School][2]
-------------------------------------


### By: [Adam Kinson][3]

This project is a mock social network site built with Ruby on Rails.  Some of the included features are:
* Photo uploads to Amazon S3
* Secure passwords and cookie-based authentication
* RSpec test coverage, with some features (e.g. Photos) being built strictly test-first
* Delayed job email notifications with a worker dyno
* Twitter Bootstrap front end
* Simple user search using SQL and regex matchers


### Product Walkthrough

1. You'll start on the Sign Up page. Create your own user account to continue (fake emails are totally acceptable).
  * If you sign up with a valid email address, you'll receive an actual welcome email!
2. After sign up, you’ll land on your Profile page.  Hit the Edit Profile button to add a personal touch.
3. Next, let's take a look at the Timeline.  Click the Timeline link right below your cover photo.
  * It'll look boring until you add a post.  You can like or delete any post you create with the links provided.
  * There's also a space for adding comments below each post.
4. On the Photos page, you can upload photos right to Amazon S3.
  * You can enter a URL or use the file browser to upload an image from your local machine.
  * After uploading, you'll land on that photo's show page, where you can do the usual commenting/liking/deleting.
5. To find some friends, use the search feature, which will match any string of letters to other users’ first or last names.  Enter ‘a’ and you should get a good number of results.
    * Just a note about friendships... you won’t be able to view individual photos unless that user has friended you.
6. Lastly, let's look at the newsfeed.  This is the default home page when you sign in as an existing user, but when you’re already logged in, you can click on the Danebook link in the top left of the navbar to go there.
  * Here you’ll see posts from the last 7 days by any users you have friended, along with all comments on those posts.
  * On the left side, you’ll get a list of those recently active users sorted chronologically.

Thanks for reading and playing with the app!  Enjoy!


[1]: http://ajk-danebook.herokuapp.com
[2]: http://www.vikingcodeschool.com
[3]: https://github.com/kinsona/danebook
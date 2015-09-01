[The Danebook][1]
============
Rails Project from [Viking Code School][2]
-------------------------------------


### Student: [Adam Kinson][3]

This project is a mock social network site built with Ruby on Rails.  Some of the included features are:
* Photo uploads to Amazon S3
* Secure passwords and cookie-based authentication
* RSpec test coverage, with some features (e.g. Photos) being built strictly test-first
* Delayed job email notifications with a worker dyno
* Twitter Bootstrap front end
* Simple user search using SQL and regex matchers


Feel free to create your own user or log in as our default user to explore:
* email: foo@bar.com
* password: foobar

If you sign up with a valid email address in production, you'll get to see our email notification system in action.  The development environment uses the [letter_opener][4] gem to preview outgoing emails.


1. Sign Up!
  * ...or skip and log in with Foo Bar
2. If you signed up as a new user, you’ll land on your profile page.
  * Edit Profile, add some details
3. Timeline link
  * You’ll see some of your info and an empty post form.  Let’s add a new post
    * You can like or delete your post with the links provided.
  * Let’s add a comment on your new post.
    * As with the post, you can like or delete your comments
4. Photos link
  * Add Photo button
  * Enter a URL or use the file browser to upload an image from your local machine
    * provide a URL
  * Will land on photo’s page
    * Let’s comment on the photo.
    * You can also use the links below the image to set the photo as your profile or cover image, or you can delete the photo.
    * For now, let’s add it as a cover image, bringing us back to the profile page
5. We want to look at the Friends link, but we currently have no Friends
6. Let’s use the search feature, which will match any string of letters to other users’ first or last names.  Enter ‘a’ and you should get a good number of results.
  * Pick 4-5 of these randos and add them as friends using the button provided.
  * Click on one of the names to jump to that user’s profile (it will look a lot like yours, only with more stuff)
    * If they have photos, take a look at their Photos page.  Note that when you hover over a photo on this page, it will show the date it was uploaded.
    * You won’t be able to view a photo unless that user has friended you.
7. Now that you’ve got friends, let’s go back to your profile.  Click the thumbnail of your user image in the top right, next to the Log Out link
8. Then hit your Friends link
  * Here you can jump to your friends’ profiles, or unfriend them if you’re tired of their politics
9. Now that you have friends and a photo, let’s go back to the Timeline to see what’s different.
  * Notice that you now have 2 panels on the right, one showing up to 9 photos and the other showing up to 6 friends.
10. Lastly, let’s look at the newsfeed.  This is the default home page when you sign in as an existing user, but when you’re already logged in, you can click on the Danebook link in the top left of the navbar to go there.
  * Here you’ll see posts from the last 7 days by any users you have friended, along with all comments on those posts.
  * On the left side, you’ll get a list of those recently active users sorted chronologically.





[1]: http://ajk-danebook.herokuapp.com
[2]: http://www.vikingcodeschool.com
[3]: https://github.com/kinsona/danebook
[4]: https://rubygems.org/gems/letter_opener/versions/1.4.1
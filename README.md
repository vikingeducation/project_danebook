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


[1]: http://ajk-danebook.herokuapp.com
[2]: http://www.vikingcodeschool.com
[3]: https://github.com/kinsona/danebook
[4]: https://rubygems.org/gems/letter_opener/versions/1.4.1
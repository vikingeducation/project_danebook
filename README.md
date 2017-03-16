This is a Facebook clone built to practice Rails associations, polymorphism, integration with S3, Paperclip, and SendGrid, and validations. 

There's a short test suite of mostly-passing tests - just run `rspec` from the root directory. 

Features:

*Polymorphic associations on Comments and Likes.
*Custom authentication with has_secure_password (see application_controller.rb & sessions_controller.rb).
*Photo uploading with Amazon S3 and Paperclip.
*Small test suite in RSpec.
*AJAX liking and posting with JavaScript response templates (see views/posts & views/likes).

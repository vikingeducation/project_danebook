Project Danebook
========

This is the Real Dane deal people. Danebook is a social networking web application built utilizing RESTful architecture and Ruby on Rails.  The complete site is mobile friendly.

#[DEMO](https://www.youtube.com/watch?v=6BuZpCvuC5o)
#[LIVE APP](https://glacial-temple-38122.herokuapp.com/)

##Getting Started
- - -

###Prerequisites
Your local machine will need access to the following:

* Ruby version 2.2.1 or newer
* Rails 5.0
* PostgreSQL

The following gem are needed to run the bundle install command:

* Bundler

The remaining gems will be installed with bundler.


###Setup

Fork and clone the repo to your local machine.

Run ```bundle install``` in the CLI.

Proceed after a successful bundle install.

Run ```rails db:migrate db:seed``` in the CLI to create the PostgreSQL database and seed it with sample users.

Run ```rails s``` in the CLI, open a browser and direct it to localhost:3000.

You can either create a new user or logon with any of the following email/password combos:

	# Replace # with any integer between 1 and 30 to access any of the pre-populated users
	email: chuck#@norris.com
	password: chuckskick

##Technical Notes
- - -

###Setting up the comment and like tables
Comments and likes have a polymorphic relationship with the Photo, Post, and Comment(self association for comment) tables.  Each comment and like will belong to a user.  When a user is destroyed, the associated comments and likes will be destroyed.

###Architecting the friendships
A self association was used to connect a user with another user. A separate table, the friendings table, holds the connection between users and maintains uniqueness so that multiple friendships cannot be sent for the same relationship.

###Paperclip and S3 photo storage

Paperclip in conjunction with S3 is utilized to manage the photo upload.  Each photo is saved in 4 different forms, thumb size, medium size, large size, and the original.

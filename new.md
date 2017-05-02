2017
====

April
-----

### 2017-04-29 10:38, First batch of Evernote exports done. 

Will continue in a bit. But for now, I'll finish up my Danebok specs... Writing specs is something I need to get better (and faster) at.

 

### 2017-04-30 10:03, untitled. 

Took my car in for servicing last Thursday. Johari picked me up. I asked him about his kids who, as it turns out, are actually pretty close in age to me. He says he has a son who's super atheltic, another who doesn't want to graduate, a youngest daughter who's only 19 an, and an eldest daughter who is "super fierce". Both Johari and his wife are afraid to talk to her lol.

 

### 2017-04-30 14:47, Going to watch Guardians of the Galaxy 2 with Kaier, Lorne and Zhong Yi. 

I should really be working. But nevermind. Will get Gong Cha after.

 

May
---

### 2017-05-02 11:02, blah 


 

### 2017-05-02 11:05, Paperclip S4 403(Forbidden). 

The error message is fairly obvious. It means you don't have access to a file.
To fix it, add the appropriate S3 Bucket Policy to your S3 bucket.
Refer to [s3browser.com](http://s3browser.com/working-with-amazon-s3-bucket-policies.php).

 

### 2017-05-02 14:15, NameError: wrong constant name xxx. 

Just found out that when specifying the parent of a polymorphic object, you have to use the correct case.
For example, commentable_type: 'post' will give you the above NameError, whereas commentable_type: 'Post' will not.

 

### 2017-05-02 14:15, ls 


 

### 2017-05-02 14:35, Calling a Polymorphic Object's Parent 

A Post has many comments through as commentable
So post.comments works
A comment belongs_to commentable. To call post, I would have to use commentable
How do I set up the comment.post method?

 

### 2017-05-03 09:52, RSpec View Spec 

If you want to see the HTML output in a view spec, you can use `print render`
`save_and_open_page` only works with integration tests
 


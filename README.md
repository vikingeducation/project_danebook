# Danebook Project  

![Danebook](https://github.com/BranLiang/project_danebook/blob/master/public/danebook.png)

### Intro  
A simple social media website, you can friending people and posting text or photo here. The task originate from Viking Code school and created by Bran Liang during his study period. Anyone is feel to use it fro any case.  
[Heroku live link](https://cool-danebook.herokuapp.com/)   
Bonus: if you sign up using your real email, you will receive a special awesome email :D

### Key features  
* Devise based authentication system  
* Sendgrid based email background sending function  
* Mobile friendly front-end based on Bootstrap  
* Amazon s3 powered file storage system, you can change your profile or cover image at your will.
* Simple but functional user search function, based on the SQL query
* User has self association, which means you can friend other user as your friends or remove it's frienship..so sad
* You can also like a post or image, or commenting on a post or an image, because all the likes and comments has polymorphic association, which makes them really flexible that any object can has likes or comments.
* News feed windows is provided, which makes user can see all their posts as well as their friend's posts.  
* Bullet gem is used to get rid of all the N+1 bug
* test is covered, although the portion is still very limited.

### Update (2016-09-24)  
* Add ajax to the post and comments, now make a new comment or post will not refresh the page, and the the new comment or post will show on the page immediately.  
* Remove the new photo page, instead A light box is added when user click the new photo page.  

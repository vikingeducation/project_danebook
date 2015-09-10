README
======

Try it: [Link](joseph-lozano-danebook.herokuapp.com/)

Danebook is my stab at social media site. It features fully working posting, commenting, photo-uploading, and friending.


Some things of note: Comments are polymorphic, and the same model is used for comments on both posts and photos. Likes are also polymorphic: Posts, Comments, and Photos are likeable.

Adding and deleting comments and posts, as well as liking and unliking are all handled via AJAX requests. Only the relevant information is sent and requested, preventing a completing page refresh. jQuery is used to update the page on a successful AJAX request.

Friendings are a handling using a join table to keep track of two users. When a user (a) requests another user (b) to be his friend, their names are added to the join table in that order. When User (b) accepts the friend requests, the names are added in again, but in reverse order.

This keeps track of friendships, where a pair of names appears twice in both orders, and requests, where the pair of names, appears only once, and the first name is the requester, the second the requestee.

Photo uploading is handled on Amazons, s3 service, with the paperclip and aws-sdk gems helping out.

Finally, the whole website is hosted on Heroku. You can access it via the link above.
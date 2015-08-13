require "rails_helper"

RSpec.describe CommentMailer, type: :mailer do

  describe "notification after user's content has been commented on" do

    context "comment was made on a post" do

      let(:post_comment) { create(:post_comment) }

      let(:mail) { CommentMailer.notify(post_comment) }

      it 'renders the subject' do
        expect(mail.subject).to eql("#{post_comment.author.name} commented on your post!")
      end

      it 'renders the receiver email' do
        expect(mail.to).to eql([post_comment.commentable.author.email])
      end

      it 'renders the sender email' do
        expect(mail.from).to eql(['admin@danebook.com'])
      end

      it 'displays the name of the commenter in email body' do
        expect(mail.body.encoded).to match(post_comment.author.name)
      end

      it "displays the link to see the comment" do
        expect(mail.body.encoded).to match(user_timeline_url(post_comment.commentable.recipient_user.id))
      end
    end

  end
end

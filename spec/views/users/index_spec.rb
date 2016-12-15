require 'rails_helper'

describe "users/index.html.erb" do
    let(:user){ create(:user) }
    let(:profile){create(:profile, user: user)}
    let(:post){create(:post, user: user)}
    let(:like){ create(:like, user: user, likeable: post) }
    let(:like2){ create(:like, likeable: post) }
    let(:like3){ create(:like, likeable: post) }
    let(:like4){ create(:like, likeable: post) }

  describe "shows the right number of likes" do
    context "posts" do
        before :each do 
          @user = user
          profile
          def view.current_user
            @user
          end
          @post = Post.new
          @posts = user.posts
        end

    

        it "shows no likes if there are no likes" do
            post
            render
            expect(rendered).to match(post.body)
            expect(rendered).to_not match("like this")
        end

        it "shows you like if you're the only person who likes it" do
            post
            like
            render
            expect(rendered).to match(" You</a><p>like this </p>")
        end

        it "shows you and someone else likes it" do
            post
            like
            like2.user.first_name = "aaa"
            like2.user.last_name = "bbb"
            like2.user.save
            render
            expect(rendered).to have_content("You and ")
            expect(rendered).to have_content("aaa bbb like this")
        end

        it "shows you and someone else and some number of people like it" do
            post
            like
            like2
            like3
            like4
            render
            expect(rendered).to have_content("You and ")
            expect(rendered).to have_content(like4.user.last_name)
            expect(rendered).to have_content("and 2 others like this")
        end


        it "shows someone else likes it" do
            post
            like4
            render
            expect(rendered).to have_content(like4.user.last_name)
            expect(rendered).to have_content("likes this")
        end

        it "shows someone else and some number of people like it" do
            post
            like2
            like3
            like4
            render
            expect(rendered).to have_content(like4.user.last_name)
            expect(rendered).to have_content("and 2 others like this")
        end
    end

    context "comments" do
        before :each do 
          @user = user
          profile
          def view.current_user
            @user
          end
          @post = Post.new
          @posts = user.posts
        end

        let(:user){ create(:user) }
        let(:profile){create(:profile, user: user)}
        let(:post){create(:post, user: user)}
        let(:comment){create(:comment, user: user, commentable: post)}
        let(:like){ create(:like, user: user, likeable: comment) }
        let(:like2){ create(:like, likeable: comment) }
        let(:like3){ create(:like, likeable: comment) }
        let(:like4){ create(:like, likeable: comment) }

        it "shows no likes if there are no likes" do
            post
            comment
            render
            expect(rendered).to match(comment.body)
            expect(rendered).to_not match("like this")
        end

        it "shows you like if you're the only person who likes it" do
            post
            comment
            like
            render
            expect(rendered).to match("You</a> like this</div>")
        end 

        it "shows you and someone else likes it" do
            post
            comment
            like
            like2.user.first_name = "aaa"
            like2.user.last_name = "bbb"
            like2.user.save
            render
            expect(rendered).to have_content("You and ")
            expect(rendered).to have_content("aaa bbb like this")
        end

        it "shows you and someone else and some number of people like it" do
            post
            comment
            like
            like2
            like3
            like4
            render
            expect(rendered).to have_content("You and ")
            expect(rendered).to have_content(like4.user.last_name)
            expect(rendered).to have_content("and 2 others like this")
        end

        it "shows someone else likes it" do
            post
            comment
            like4
            render
            expect(rendered).to have_content(like4.user.last_name)
            expect(rendered).to have_content("likes this")
        end

        it "shows someone else and some number of people like it" do
            post
            comment
            like2
            like3
            like4
            render
            expect(rendered).to have_content(like4.user.last_name)
            expect(rendered).to have_content("and 2 others like this")
        end
    end
  end
end

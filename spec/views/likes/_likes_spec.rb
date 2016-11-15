require 'rails_helper'

describe 'likes/_likes.html.erb' do
  let(:male){create(:male)}
  let(:user){create(:user, :gender => male)}
  let(:post_one){create(:post, :user => user)}
  let(:post_two){create(:post, :user => user)}
  let(:post_three){create(:post, :user => user)}
  let(:post_four){create(:post, :user => user)}
  let(:post_five){create(:post, :user => user)}
  let(:users){create_list(:user, 5)}
  let(:posts){[post_one, post_two, post_three, post_four, post_five]}
  let(:self_likes) do
    self_likes = []
    posts.each do |post|
      self_likes << create(:post_like, :user => user, :likeable => post)
    end
    self_likes
  end
  let(:likes) do
    likes = []
    5.times do |i|
      (i + 1).times do |j|
        likes << create(:post_like, :user => users[j], :likeable => posts[i])
      end
    end
    likes
  end

  before do
    @user = user
    def view.current_user
      @user
    end

    def view.signed_in_user?
      true
    end
  end

  describe 'grammar' do
    before do
      likes
    end

    context 'current user does not like post' do
      it 'makes sense when other user likes is 1' do
        render :partial => 'likes/likes', :locals => {:likeable => post_one}
        str = "#{users.first.name} likes this"
        expect(rendered).to have_content(str)
      end

      it 'makes sense when other user likes is 2' do
        render :partial => 'likes/likes', :locals => {:likeable => post_two}
        str = "#{users[0].name} and #{users[1].name} like this"
        expect(rendered).to have_content(str)
      end

      it 'makes sense when other user likes is 3' do
        render :partial => 'likes/likes', :locals => {:likeable => post_three}
        str = "#{users[0].name}, #{users[1].name} and 1 other person like this"
        expect(rendered).to have_content(str)
      end

      it 'makes sense when other user likes is 4' do
        render :partial => 'likes/likes', :locals => {:likeable => post_four}
        str = "#{users[0].name}, #{users[1].name} and 2 other people like this"
        expect(rendered).to have_content(str)
      end
    end

    context 'current user does like post' do
      before do
        self_likes
      end

      it 'makes sense when only the current user likes the post' do
        post = create(:post, :user => user)
        like = create(:post_like, :user => user, :likeable => post)
        render :partial => 'likes/likes', :locals => {:likeable => post}
        str = "You like this"
        expect(rendered).to have_content(str)
      end

      it 'makes sense when other user likes is 1' do
        render :partial => 'likes/likes', :locals => {:likeable => post_one}
        str = "You and #{users.first.name} like this"
        expect(rendered).to have_content(str)
      end

      it 'makes sense when other user likes is 2' do
        render :partial => 'likes/likes', :locals => {:likeable => post_two}
        str = "You, #{users[0].name} and #{users[1].name} like this"
        expect(rendered).to have_content(str)
      end

      it 'makes sense when other user likes is 3' do
        render :partial => 'likes/likes', :locals => {:likeable => post_three}
        str = "You, #{users[0].name}, #{users[1].name} and 1 other person like this"
        expect(rendered).to have_content(str)
      end

      it 'makes sense when other user likes is 4' do
        render :partial => 'likes/likes', :locals => {:likeable => post_four}
        str = "You, #{users[0].name}, #{users[1].name} and 2 other people like this"
        expect(rendered).to have_content(str)
      end
    end
  end
end









describe 'POST #create' do
    let(:post_create_post) do
      post :create, :user_id => user.id,
                    :post => attributes_for(
                      :post,
                      :user_id => user.id
                    )
    end

    let(:post_create_invalid) do
      post :create, :user_id => user.id,
                    :post => attributes_for(
                      :post,
                      :body => ''
                    )
    end

    context 'the user is signed in' do
      it 'creates a new post when valid' do
        expect {post_create_post}.to change(Post, :count).by(1)
      end

      it 'sets a success flash when valid' do
        post_create_post
        expect(flash[:success]).to_not be_nil
      end

      it 'does not create a post when invalid' do
        expect {post_create_invalid}.to change(Post, :count).by(0)
      end

      it 'sets an error flash when invalid' do
        post_create_invalid
        expect(flash[:error]).to_not be_nil
      end
    end

    context 'the user is signed out' do
      before do
        logout
      end

      it 'does not create a post' do
        expect {post_create_post}.to change(Post, :count).by(0)
      end

      it 'redirects to root' do
        post_create_post
        expect(response).to redirect_to root_path
      end

      it 'sets an error flash' do
        post_create_post
        expect(flash[:error]).to_not be_nil
      end
    end
  end

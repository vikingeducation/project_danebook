require 'rails_helper'

describe UsersController do
    describe 'user access' do
        let(:user) { create(:user) }
        let(:users) { [user, create(:user)] }

        before do
          set_http_referer
        end

        context 'Get #index' do
            it 'collects users into @users' do
                another_user = create(:user)

                get :index

                expect(assigns(:users)).to match_array [user, another_user]
            end
        end

        # ----------------------------------------
        # POST #create
        # ----------------------------------------

        describe 'POST #create' do
            let(:post_create_valid) do
                post :create,
                     user: attributes_for(:user)
            end

            let(:post_create_invalid) do
                post :create,
                     user: {
                         first_name: '',
                         last_name: '',
                         email: '',
                         birth_date: '',
                         password: '',
                         password_confirmation: ''
                     }
            end

            context 'the user is NOT logged in' do
                context 'the data is valid' do
                    it 'creates the user' do
                        expect { post_create_valid }.to change(User, :count).by(1)
                    end

                    it 'redirects to the user' do
                        post_create_valid
                        expect(response).to redirect_to root_url
                    end

                    it 'sets a success flash' do
                        post_create_valid
                        expect(flash[:success]).to_not be_nil
                    end
                end

                context 'the data is invalid' do
                    it 'does NOT create the user' do
                        expect { post_create_invalid }.to change(User, :count).by(0)
                    end

                    it 'renders the new template' do
                        post_create_invalid
                        expect(response).to render_template('sessions/new')
                    end

                    it 'sets an error flash' do
                        post_create_invalid
                        expect(flash[:error]).to_not be_nil
                    end
                end
            end

            context 'the user IS logged in' do
                before do
                  create_session(user)
                  post_create_valid
                end

                it 'redirects to root path' do
                    expect(response).to redirect_to(root_path)
                end

                it 'sets an error flash' do
                    expect(flash[:error]).to_not be_nil
                end
            end
        end

        context 'GET #show works as normal' do
            let(:get_show) { get :show, id: user.id }

            before do
                user
                get_show
            end

            it 'shows show page when visiting that user ids page' do
                expect(response).to render_template(:show)
            end

            it 'sets an instance variable to the user' do
                expect(assigns[:user]).to eq(user)
            end
        end

    # ----------------------------------------
    # PUT #update
    # ----------------------------------------

    describe 'PUT #update' do
      let(:put_update_valid) do
          put :update,
              id: user.id,
              user: {
                  profile_pic_id: photo.id
              }
      end

        let(:put_update_invalid) do
            put :update,
                id: user.id,
                user: {
                    first_name: '',
                    last_name: '',
                    email: '',
                    password: '',
                    password_confirmation: ''
                }
        end

        let(:photo){ user.photo_posts.create }

        context 'the user IS logged in' do

          before do
            create_session(user)
            photo
          end

            context 'the data is valid' do
                before do
                    put_update_valid
                    user.reload
                end

                it 'updates the user' do
                    expect(user.profile_pic_id).to eq(photo.id)
                end

                it 'redirects to the user' do
                    expect(response).to redirect_to :back
                end

                it 'sets a success flash' do
                    expect(flash[:success]).to_not be_nil
                end
            end

            context 'the data is invalid' do

                before do
                    put_update_invalid
                end

                it 'does not update the user' do
                    expect(user.profile_pic).to be_nil
                end

                it 'renders the edit template' do
                    expect(response).to redirect_to root_url
                end

                it 'sets an error flash' do
                    expect(flash[:error]).to_not be_nil
                end
            end
        end

        context 'the user is NOT logged in' do
            before do
                put_update_valid
            end

            it 'redirects to login' do
                expect(response).to redirect_to(login_path)
            end

            it 'sets an error flash' do
                expect(flash[:error]).to_not be_nil
            end
        end
    end
  end
end

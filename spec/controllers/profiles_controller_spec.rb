require 'rails_helper'

describe ProfilesController do
  let(:user) { create(:user) }

  before do
    set_http_referer
  end

  # ----------------------------------------
  # PUT #update
  # ----------------------------------------

  describe 'PUT #update' do

    let(:put_update_valid) do
      put :update, id: user.id,
        profile: {
          college: "test college",
          hometown: "test hometown",
          currently_lives: "test lives",
          telephone: "1-714-902-4901",
          words_to_live_by: "test words",
          about_me: "test about"
        }
    end

    let(:put_update_invalid) do
      put :update,
        profile: {
          college: "a"*100
        }
    end


    context 'the user IS logged in' do

      before do
        create_session(user)
      end

        context 'the data is valid' do
            before do
                put_update_valid
                user.reload
            end

            it 'updates the user' do
                expect(user.profile.college).to eq("test college")
                expect(user.profile.about_me).to eq("test about")
            end

            it 'redirects to the user' do
                expect(response).to redirect_to user_profile_path(user)
            end

            it 'sets a success flash' do
                expect(flash[:success]).to_not be_nil
            end
        end

        context 'the data is invalid' do

            before do
                put_update_invalid
                user.reload
            end

            it 'does not update the user' do
                expect(user.profile.college).to be_nil
            end

            it 'renders the edit template' do
                expect(response).to render_template :edit
            end

            it 'sets an error flash' do
                expect(flash[:error]).to_not be_nil
            end
        end
    end

    context 'the user is NOT logged in' do
        before do
            put_update_valid
            user.reload
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

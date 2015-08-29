require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do


  describe 'GET #index' do

    let(:searcher) { class_double("Profile").as_stubbed_const }
    let(:targets) { create_list(:user, 2) }

    before do
      profiles = targets.map { |u| u.profile }
      allow(searcher).to receive(:search).and_return(profiles)
      get :index, :search => 'query'
    end


    it 'puts users from search results into collection' do
      expect(assigns[:users]).to eq(targets)
    end

  end


  describe 'GET #edit' do

    let(:logged_in_user) { create(:user) }

    before do
      request.cookies[:auth_token] = logged_in_user.auth_token
    end


    it { should use_before_action(:require_current_user) }


    context 'when authorized' do

      it 'assigns @profile based on current user' do
        get :edit, :user_id => logged_in_user.id
        expect(assigns[:profile]).to eq(logged_in_user.profile)
      end

    end


    context 'when unauthorized' do

      let(:victim) { create(:user) }

      before do
        get :edit, :user_id => victim.id
      end


      it 'sets Unauthorized flash' do
        expect(flash[:danger]).to eq("You're not authorized to do this!")
      end

      it 'redirects to profile that was edit was attempted on' do
        expect(response).to redirect_to(user_path(victim.id))
      end

    end

  end



  describe 'PATCH #update' do

    let(:new_user) { create(:user, :profile => build(:base_profile)) }

    before do
      request.cookies[:auth_token] = new_user.auth_token
    end


    it { should use_before_action(:require_current_user) }


    context 'when authorized' do

      before do
        put :update, :id => new_user.profile.id, :user_id => new_user.id, :profile => attributes_for(:full_profile)
      end

      it 'assigns @profile' do
        expect(assigns[:profile]).to eq(new_user.profile)
      end

      it 'sets Success flash' do
        expect(flash[:success]).to eq("Profile updated!")
      end

      it 'redirects to the updated profile' do
        expect(response).to redirect_to(user_path(new_user.id))
      end

    end


    context 'when unauthorized' do

      let(:victim) { create(:user) }

      before do
        put :update,  :id => victim.profile.id, :user_id => victim.id, :profile => attributes_for(:full_profile)
      end

      it 'sets Unauthorized flash' do
        expect(flash[:danger]).to eq("You're not authorized to do this!")
      end

      it 'redirects to profile that was edit was attempted on' do
        expect(response).to redirect_to(user_path(victim.id))
      end

    end

  end

end

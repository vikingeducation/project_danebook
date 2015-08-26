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

end

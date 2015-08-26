require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do


  describe 'GET #index' do

    let(:searcher) { class_double("Profile").as_stubbed_const }
    let(:query) { 'foo' }

    before do
      allow(searcher).to receive(:search).and_return('results')
      get :index, :search => query
    end

    it 'assigns @profiles to search results' do
      expect(assigns[:profiles]).to eq('results')
    end

  end

end

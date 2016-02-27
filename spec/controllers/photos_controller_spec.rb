require 'rails_helper'

RSpec.describe PhotosController, type: :controller do
  before :each do
    AWS.stub!
  end

end

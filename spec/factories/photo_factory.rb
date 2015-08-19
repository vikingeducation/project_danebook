include ActionDispatch::TestProcess

FactoryGirl.define do

  factory :photo do
    photo { fixture_file_upload(Rails.root.join('spec', 'support', 'test.jpg'), 'image/jpg') }
    owner
  end

end

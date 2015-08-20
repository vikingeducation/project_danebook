include ActionDispatch::TestProcess

FactoryGirl.define do

  factory :photo do
    photo { fixture_file_upload(Rails.root.join('spec', 'support', 'test.jpg'), 'image/jpg') }
    owner
  end

  factory :bad_photo do
    photo { fixture_file_upload(Rails.root.join('spec', 'support', 'bad_photo.txt'), 'text/plain') }
    owner
  end

end

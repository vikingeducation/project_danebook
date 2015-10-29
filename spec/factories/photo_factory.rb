include ActionDispatch::TestProcess

FactoryGirl.define do

  factory :photo do
    photo { fixture_file_upload(Rails.root.join('spec', 'support', 'test.jpg'), 'image/jpg') }
    poster
  end

  factory :bad_photo do
    photo { fixture_file_upload(Rails.root.join('spec', 'support', 'bad_photo.txt'), 'text/plain') }
    poster
  end

end

require 'rails_helper'

describe 'posts/_info_box_photos.html.erb' do
  let(:user){ build(:user, :with_profile)}
  let(:photos){ create_list(:photo, 3, user: user)}
  it 'displays the correct number of photos' do
    render partial: 'posts/info_box_photos', locals: { photos: photos}
    expect(rendered).to have_text('Photos (3)')
  end
  it 'says there are no photos if user has none' do
    render partial: 'posts/info_box_photos', locals: { photos: []}
    expect(rendered).to have_text('no photos yet')
  end
  it 'has link to see more photos if user has more than 9 photos' do
    user.save
    photos = create_list(:photo, 10, user: user)
    render partial: 'posts/info_box_photos', locals: { photos: photos, user: user}
    expect(rendered).to have_link('See More Photos')
  end
end

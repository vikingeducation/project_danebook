require 'rails_helper'


feature 'Comment on a Post' do

  scenario 'with valid content length (3..140 characters)'

  scenario "with content that's too long (141 characters)"

  scenario 'with blank content'

  scenario 'if unauthorized User'

end
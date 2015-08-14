require 'rails_helper'


feature 'Make a new Friend' do

  scenario 'if a valid Friend recipient'

  scenario 'if already a Friend'

  scenario 'if trying to Friend oneself'

  scenario 'if unauthorized Friend initiator'

end


feature 'Unfriend another User' do

  scenario 'if a valid Unfriend recipient'

  scenario 'if not currently Friends'

  scenario 'if unauthorized Friend initiator'

end
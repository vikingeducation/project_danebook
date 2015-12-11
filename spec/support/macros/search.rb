module Macros
  module Search
    def submit_search(q)
      fill_in('q', :with => q)
      find('input[name="q"]').native.send_keys(:return)
    end
  end
end


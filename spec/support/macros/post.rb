module Macros
  module Post
    def submit_post(body=nil)
      fill_in('post_body', :with => body ? body : FactoryHelper.text)
      find('input[value="Post"]').click
    end
  end
end
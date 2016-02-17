require 'rails_helper'



describe User do




  it "user not created with an invalid password"
  it "user not created with a duplicate email address"
  it "generate_token gets called before user create"
  it "generate_token creates a different token"
  it "regenerate_auth_token invalidates old token"
  it "regenerate_auth_token creates a different new token"
  it "creating a new user creates a new profile too"
  it "deleting a user deletes their profile too"




end
require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest

  def setup
    @user = users :test_user
  end

  test 'should flash for invalid email address' do
    post password_resets_path, password_reset: { email: 'nomail@nomail.com' }
    assert flash? 'danger'
  end

  test 'should flash for password reset email' do
    post password_resets_path, password_reset: { email: @user.email }
    assert flash? 'info'
  end

  test 'should redirect for invalid password reset token' do
    @user.make_reset_digest
    get edit_password_reset_url('wrong_token',
                                 email: @user.email)
    assert_redirected_to root_url
  end

  test 'should redirect for incorrect email address' do
    @user.make_reset_digest
    get edit_password_reset_url(@user.reset_token,
                                 email: 'incorrect@email.com')
    assert_redirected_to root_url
  end

  test 'should show password reset page for correct token and email address' do
    @user.make_reset_digest
    get edit_password_reset_path(@user.reset_token,
                                 email: @user.email)
    assert_template 'static_pages/_new_password'
  end

  test 'should render password reset page for incorrect password combination' do
    @user.make_reset_digest
    patch password_reset_path(@user.reset_token,email: @user.email),
                              user: { password: 'foobar',
                                      password_confirmation: 'flubber' }
    assert flash? 'danger'
    assert_template 'static_pages/_new_password'
  end

  test 'should redirect to login page for correct password combination' do
    @user.make_reset_digest
    patch password_reset_path(@user.reset_token,email: @user.email),
                              user: { password: 'foobar',
                                      password_confirmation: 'foobar' }
    assert flash? 'success'
    assert_redirected_to login_path
  end

end

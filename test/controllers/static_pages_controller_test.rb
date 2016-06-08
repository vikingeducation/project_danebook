require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get friends" do
    get :friends
    assert_response :success
  end

  test "should get photos" do
    get :photos
    assert_response :success
  end

  test "should get timeline" do
    get :timeline
    assert_response :success
  end

end

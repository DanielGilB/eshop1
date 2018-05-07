require 'test_helper'

class Admin::OrderControllerTest < ActionController::TestCase
  test "should get close" do
    get :close
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end

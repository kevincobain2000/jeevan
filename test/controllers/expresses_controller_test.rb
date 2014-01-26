require 'test_helper'

class ExpressesControllerTest < ActionController::TestCase
  setup do
    @express = expresses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:expresses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create express" do
    assert_difference('Express.count') do
      post :create, express: {  }
    end

    assert_redirected_to express_path(assigns(:express))
  end

  test "should show express" do
    get :show, id: @express
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @express
    assert_response :success
  end

  test "should update express" do
    patch :update, id: @express, express: {  }
    assert_redirected_to express_path(assigns(:express))
  end

  test "should destroy express" do
    assert_difference('Express.count', -1) do
      delete :destroy, id: @express
    end

    assert_redirected_to expresses_path
  end
end

require 'test_helper'

class AcformsControllerTest < ActionController::TestCase
  setup do
    @acform = acforms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:acforms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create acform" do
    assert_difference('Acform.count') do
      post :create, acform: { state: @acform.state, student_id: @acform.student_id }
    end

    assert_redirected_to acform_path(assigns(:acform))
  end

  test "should show acform" do
    get :show, id: @acform
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @acform
    assert_response :success
  end

  test "should update acform" do
    patch :update, id: @acform, acform: { state: @acform.state, student_id: @acform.student_id }
    assert_redirected_to acform_path(assigns(:acform))
  end

  test "should destroy acform" do
    assert_difference('Acform.count', -1) do
      delete :destroy, id: @acform
    end

    assert_redirected_to acforms_path
  end
end

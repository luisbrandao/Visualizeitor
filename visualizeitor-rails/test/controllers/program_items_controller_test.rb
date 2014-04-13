require 'test_helper'

class ProgramItemsControllerTest < ActionController::TestCase
  setup do
    @program_item = program_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:program_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create program_item" do
    assert_difference('ProgramItem.count') do
      post :create, program_item: { column: @program_item.column, row: @program_item.row }
    end

    assert_redirected_to program_item_path(assigns(:program_item))
  end

  test "should show program_item" do
    get :show, id: @program_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @program_item
    assert_response :success
  end

  test "should update program_item" do
    patch :update, id: @program_item, program_item: { column: @program_item.column, row: @program_item.row }
    assert_redirected_to program_item_path(assigns(:program_item))
  end

  test "should destroy program_item" do
    assert_difference('ProgramItem.count', -1) do
      delete :destroy, id: @program_item
    end

    assert_redirected_to program_items_path
  end
end

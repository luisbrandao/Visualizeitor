require 'test_helper'

class InternshipsControllerTest < ActionController::TestCase
  setup do
    @internship = internships(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:internships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create internship" do
    assert_difference('Internship.count') do
      post :create, internship: { assistType: @internship.assistType, contact_id: @internship.contact_id, end: @internship.end, hours: @internship.hours, internType: @internship.internType, start: @internship.start, student_id: @internship.student_id, teacher_id: @internship.teacher_id }
    end

    assert_redirected_to internship_path(assigns(:internship))
  end

  test "should show internship" do
    get :show, id: @internship
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @internship
    assert_response :success
  end

  test "should update internship" do
    patch :update, id: @internship, internship: { assistType: @internship.assistType, contact_id: @internship.contact_id, end: @internship.end, hours: @internship.hours, internType: @internship.internType, start: @internship.start, student_id: @internship.student_id, teacher_id: @internship.teacher_id }
    assert_redirected_to internship_path(assigns(:internship))
  end

  test "should destroy internship" do
    assert_difference('Internship.count', -1) do
      delete :destroy, id: @internship
    end

    assert_redirected_to internships_path
  end
end

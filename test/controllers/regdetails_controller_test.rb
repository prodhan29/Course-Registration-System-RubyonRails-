require 'test_helper'

class RegdetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @regdetail = regdetails(:one)
  end

  test "should get index" do
    get regdetails_url
    assert_response :success
  end

  test "should get new" do
    get new_regdetail_url
    assert_response :success
  end

  test "should create regdetail" do
    assert_difference('Regdetail.count') do
      post regdetails_url, params: { regdetail: { cgpa: @regdetail.cgpa, course: @regdetail.course, semester_id: @regdetail.semester_id, user_id: @regdetail.user_id } }
    end

    assert_redirected_to regdetail_url(Regdetail.last)
  end

  test "should show regdetail" do
    get regdetail_url(@regdetail)
    assert_response :success
  end

  test "should get edit" do
    get edit_regdetail_url(@regdetail)
    assert_response :success
  end

  test "should update regdetail" do
    patch regdetail_url(@regdetail), params: { regdetail: { cgpa: @regdetail.cgpa, course: @regdetail.course, semester_id: @regdetail.semester_id, user_id: @regdetail.user_id } }
    assert_redirected_to regdetail_url(@regdetail)
  end

  test "should destroy regdetail" do
    assert_difference('Regdetail.count', -1) do
      delete regdetail_url(@regdetail)
    end

    assert_redirected_to regdetails_url
  end
end

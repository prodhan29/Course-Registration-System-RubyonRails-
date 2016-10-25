require 'test_helper'

class AppuserControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get appuser_index_url
    assert_response :success
  end

  test "should get course_result" do
    get appuser_course_result_url
    assert_response :success
  end

  test "should get update" do
    get appuser_update_url
    assert_response :success
  end

  test "should get reg_details" do
    get appuser_reg_details_url
    assert_response :success
  end

end

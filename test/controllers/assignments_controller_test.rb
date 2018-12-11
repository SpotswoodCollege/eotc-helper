require 'test_helper'

class AssignmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get assignments_create_url
    assert_response :success
  end

  test "should get destroy" do
    get assignments_destroy_url
    assert_response :success
  end

  test "should get index" do
    get assignments_index_url
    assert_response :success
  end

end

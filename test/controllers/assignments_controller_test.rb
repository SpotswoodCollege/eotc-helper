require 'test_helper'

class AssignmentsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get assignments_url
    assert_response :success
  end
end

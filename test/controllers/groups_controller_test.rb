require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get groups_url
    assert_response :success
    assert_select 'a', 'Science 101', 'There must be a Science 101 link'
  end
end

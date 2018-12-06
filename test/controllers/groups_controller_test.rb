require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Rails.application.routes.url_helpers

  test 'should get index' do
    get groups_url
    assert_response :success
    assert_select 'a', 'Science 101', 'There must be a Science 101 link'
  end

  test 'should not create group with standard role' do
    sign_in users(:average_joe)
    assert_raises 'RuntimeError: Must be logged in' do
      post groups_url group: { name: 'PEH101',
                               description: 'Physical Education Level 1',
                               creator: user.id }
    end
  end

  test 'should be able to create group' do
    user = users(:teacher_kate)
    sign_in user
    post groups_url group: { name: 'PEH101',
                             description: 'Physical Education Level 1',
                             creator: user.id }
    assert_response :found, 'Teacher could not save group'
  end

  test 'should not be able to create group with blank name' do
    user = users(:teacher_kate)
    sign_in user
    post groups_url group: { description: 'Physical Education Level 1',
                             creator: user.id }
    assert_response :bad_request, 'Group was saved nameless'
  end

  test 'should be able to create group with blank description' do
    user = users(:teacher_kate)
    sign_in user
    post groups_url group: { name: 'PEH101',
                             creator: user.id }
    assert_response :found, 'Group without description was not saved'
  end
end

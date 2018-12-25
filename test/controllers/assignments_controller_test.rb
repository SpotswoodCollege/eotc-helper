require 'test_helper'

class AssignmentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Rails.application.routes.url_helpers

  test 'should get index' do
    get assignments_url
    assert_response :success, 'Could not index assignments'
  end

  test 'should not create as standard user' do
    user = users(:average_joe)
    sign_in user

    assert_raises 'CanCan::AccessDenied' do
      post assignments_url, params: { assignment: {
        group: groups(:SCI101),
        activity: activities(:science_experiment)
      } }
    end
  end

  test 'should create assignment' do
    user = users(:teacher_kate)
    sign_in user

    post assignments_url, params: { assignment: {
      group_id: groups(:SCI101).id,
      activity_id: activities(:science_experiment).id
    } }
    assert_response :success, 'Could not create assignment'
  end

  test 'should not create with invalid activity' do
    user = users(:teacher_kate)
    sign_in user

    assert_raises 'ActiveRecord::RecordInvalid' do
      post assignments_url, params: { assignment: {
        group: groups(:SCI101),
        activity: Activity.new(name: 'Investigating the Vacuum')
      } }
    end
  end

  test 'should not create with invalid group' do
    user = users(:teacher_kate)
    sign_in user

    assert_raises 'ActiveRecord::RecordInvalid' do
      post assignments_url, params: { assignment: {
        group: Group.new(name: 'Lack of a Group'),
        activity: activities(:science_experiment)
      } }
    end
  end
end

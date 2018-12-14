require 'test_helper'

class ActivitiesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Rails.application.routes.url_helpers

  test 'should get index' do
    get activities_url
    assert_response :success
    assert_select 'a', 'Code Club', 'There must be a Code Club link'
  end

  test 'should get index with unapproved activities' do
    sign_in users(:teacher_kate)
    get activities_url
    assert_response :success
    assert_select 'a', 'Beach Trip', 'There must be a Beach Trip link'
    assert_select 'a', 'Code Club',  'There must be a Code Club link'
  end

  test 'should not create activity with standard role' do
    user = users(:average_joe)
    sign_in user
    assert_raises 'RuntimeError: Must be logged in' do
      post activities_url activity: { name: 'Pool Swim',
                                      description: 'A swim in the school pool.',
                                      activity_type: 'in_school',
                                      risk: 'high',
                                      creator: user.id }
    end
  end

  test 'should create activity' do
    user = users(:teacher_kate)
    sign_in user
    post activities_url activity: { name: 'Pool Swim',
                                    description: 'A swim in the school pool.',
                                    activity_type: 'in_school',
                                    risk: 'high',
                                    creator: user.id }
    assert_response :found, 'Teacher could not save activity'
  end

  test 'should not create activity with blank name' do
    user = users(:teacher_kate)
    sign_in user
    post activities_url activity: { description: 'A swim in the school pool.',
                                    activity_type: 'in_school',
                                    risk: 'high',
                                    creator: user.id }
    assert_response :bad_request, 'Teacher could save activity with blank name'
  end

  test 'should create activity with blank description' do
    user = users(:teacher_kate)
    sign_in user
    post activities_url activity: { name: 'Pool Swim',
                                    activity_type: 'in_school',
                                    risk: 'high',
                                    creator: user.id }
    assert_response :found,
                    'Teacher could not save activity with blank description'
  end

  test 'should not approve with standard role' do
    user = users(:average_joe)
    sign_in user
    assert_raises 'CanCan::AccessDenied' do
      patch activity_url(activities(:beach_trip)),
            params: { activity: { approve: true } }
    end
  end

  test 'should not approve community high risk activity as teacher' do
    user = users(:teacher_kate)
    sign_in user
    assert_raises 'CanCan::AccessDenied' do
      patch activity_url(activities(:beach_trip)),
            params: { activity: { approve: true } }
    end
  end

  test 'should approve community high risk activity as senior teacher' do
    user = users(:senior_teacher_bob)
    sign_in user
    patch activity_url(activities(:beach_trip)),
          params: { activity: { approve: true } }
  end
end

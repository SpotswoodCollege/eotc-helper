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
                                      creator: user }
    end
  end

  test 'should create activity' do
    user = users(:teacher_kate)
    sign_in user
    post activities_url activity: { name: 'Pool Swim',
                                    description: 'A swim in the school pool.',
                                    activity_type: 'in_school',
                                    risk: 'high',
                                    creator: user }
    assert_response :redirect, 'Teacher could not save activity'
  end

  test 'should not create activity with blank name' do
    user = users(:teacher_kate)
    sign_in user
    post activities_url activity: { description: 'A swim in the school pool.',
                                    activity_type: 'in_school',
                                    risk: 'high',
                                    creator: user }
    assert_response :bad_request, 'Teacher could save activity with blank name'
  end

  test 'should create activity with blank description' do
    user = users(:teacher_kate)
    sign_in user
    post activities_url activity: { name: 'Pool Swim',
                                    activity_type: 'in_school',
                                    risk: 'high',
                                    creator: user }
    assert_response :redirect,
                    'Teacher could not save activity with blank description'
  end

  test 'should not approve with standard role' do
    user = users(:average_joe)
    sign_in user
    assert_access_denied do
      post activity_approve_url(activities(:beach_trip))
    end
  end

  test 'should not approve community high risk activity as teacher' do
    user = users(:teacher_kate)
    sign_in user
    assert_access_denied do
      post activity_approve_url(activities(:beach_trip))
    end
  end

  test 'should approve community high risk activity as senior teacher' do
    user = users(:senior_teacher_bob)
    sign_in user
    post activity_approve_url(activities(:beach_trip))
  end

  test 'should update activity' do
    user = users(:teacher_kate)
    sign_in user

    desc = 'A trip to the beach. Whole school can come! Parent helpers needed.'

    patch activity_url(activities(:beach_trip)),
          params: { activity: { description: desc } }
  end

  test 'should not update activity with no params' do
    user = users(:teacher_kate)
    sign_in user

    assert_raises 'ActionController::ParameterMissing' do
      patch activity_url(activities(:beach_trip)),
            params: { activity: {} }
    end
  end

  test 'should not update activity with its own params' do
    user = users(:teacher_kate)
    sign_in user
    patch activity_url(activities(:beach_trip)),
          params: { activity: { name: 'Beach Trip',
                                activity_type: 'community',
                                risk: 'high',
                                creator: users(:teacher_kate) } }
  end

  test 'should not update activity with standard user' do
    user = users(:average_joe)
    sign_in user

    desc = "I don't like sand."

    assert_access_denied do
      patch activity_url(activities(:beach_trip)),
            params: { activity: { name: 'too sandy',
                                  description: desc } }
    end
  end
end

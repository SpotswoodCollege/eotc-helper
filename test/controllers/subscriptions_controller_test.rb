require 'test_helper'

class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Rails.application.routes.url_helpers

  test 'signed out users cannot see subscriptions' do
    assert_raises('RuntimeError: Must be logged in') do
      get subscriptions_url
    end
  end

  test 'signed in users can see subscriptions' do
    sign_in users(:average_joe)
    get subscriptions_url
    assert_response :success
  end

  test 'can subscribe' do
    sign_in users(:average_joe)

    get group_url groups(:ENG302)
    assert_response :success
    assert_select 'input[value="Subscribe"]'

    subs = Subscription.create user: users(:average_joe), group: groups(:ENG302)
    subs.save!

    get group_url groups(:ENG302)
    assert_response :success
    assert_select 'input[value="Unsubscribe"]'
  end

  test 'can unsubscribe' do
    sign_in users(:average_joe)

    subs = Subscription.create user: users(:average_joe), group: groups(:ENG302)
    subs.save!

    get group_url groups(:ENG302)
    assert_response :success
    assert_select 'input[value="Unsubscribe"]'

    subs.destroy!

    get group_url groups(:ENG302)
    assert_response :success
    assert_select 'input[value="Subscribe"]'
  end

  test 'should fail to create with no group' do
    sign_in users(:average_joe)

    subs = Subscription.create user: users(:average_joe)

    assert_not subs.save
  end

  test 'should fail to create with no user' do
    assert_raises 'RuntimeError: Must be logged in' do
      subs = Subscription.create group: groups(:ENG302)
      subs.save!
    end
  end
end

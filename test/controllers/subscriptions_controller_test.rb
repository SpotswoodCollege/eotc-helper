require 'test_helper'

class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

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
end

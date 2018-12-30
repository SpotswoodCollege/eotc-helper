require 'test_helper'

class PreferencesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Rails.application.routes.url_helpers

  test 'should get show' do
    sign_in users(:average_joe)
    get preferences_url
    assert_response :success
  end
end

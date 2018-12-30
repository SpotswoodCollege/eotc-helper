require 'test_helper'

class PreferencesControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get preferences_url
    assert_response :success
  end
end

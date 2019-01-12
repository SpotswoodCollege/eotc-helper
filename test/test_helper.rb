require 'coveralls'
Coveralls.wear!

require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml
    # => for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...

    # Assert that either :error or CanCan::AccessDenied occurs
    def assert_access_denied
      denied = false
      begin
        yield
        assert_response :error
        denied = true
      rescue CanCan::AccessDenied
        denied = true
      end
      assert denied
    end
  end
end

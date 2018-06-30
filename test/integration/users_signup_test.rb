require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'should accept valid user' do
    assert_difference 'User.count' do
      post users_path, params: { user: { name:  'John Smith',
                                         email: 'j.smith@example.com',
                                         password:              'password',
                                         password_confirmation: 'password' } }
    end
  end

  test 'should not accept invalid user' do
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  '',
                                         email: 'invalid@email',
                                         password:              'hunter2',
                                         password_confirmation: 'password' } }
    end
  end
end

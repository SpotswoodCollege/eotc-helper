require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should get index' do
    get groups_url
    assert_response :success
    assert_select 'a', 'Science 101', 'There must be a Science 101 link'
  end

  test 'should not create group with standard role' do
    sign_in users(:average_joe)
    assert_raises 'RuntimeError: Must be logged in' do
      group = Group.new name: 'PEH101',
                        description: 'Physical Education Level 1'
      group.save!
    end
  end

  test 'should be able to create group as teacher' do
    sign_in users(:teacher_kate)
    group = Group.new name: 'PEH101', description: 'Physical Education Level 1'
    assert group.save
  end

  test 'should not be able to create group with blank name' do
    sign_in users(:teacher_kate)
    group = Group.new description: 'Physical Education Level 1'
    assert_not group.save
  end

  test 'should be able to create group with blank description' do
    sign_in users(:teacher_kate)
    group = Group.new name: 'PEH101'
    assert group.save
  end
end

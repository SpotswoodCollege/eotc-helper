require 'test_helper'

class NotificationsMailerTest < ActionMailer::TestCase
  test 'activity_upcoming' do
    mail = NotificationsMailer.with(
      user: users(:average_joe),
      activity: activities(:measuring_trees)
    ).activity_upcoming

    assert_equal 'Activity upcoming', mail.subject
    assert_equal ['joe@example.com'], mail.to
    assert_equal ['eotc-helper@spotswoodcollege.school.nz'], mail.from
    # TODO: assert_match 'Hi', mail.body.encoded
  end
end

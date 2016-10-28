require 'test_helper'

class CourseSystemMailerTest < ActionMailer::TestCase
  test "publish_result" do
    mail = CourseSystemMailer.publish_result
    assert_equal "Publish result", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

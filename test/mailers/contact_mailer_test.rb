require "test_helper"

class ContactMailerTest < ActionMailer::TestCase
  setup do
    @expert = experts(:one)
    @submission_with_expert = contact_submissions(:one)
    @general_submission = contact_submissions(:general)
  end

  test "expert_contact" do
    mail = ContactMailer.expert_contact(@submission_with_expert)
    assert_equal "Nova sprava od #{@submission_with_expert.sender_name}", mail.subject
    assert_equal [ @expert.email ], mail.to
    assert_equal [ "noreply@beriembitcoin.sk" ], mail.from
    assert_match @submission_with_expert.sender_name, mail.body.encoded
  end

  test "admin_notification" do
    mail = ContactMailer.admin_notification(@submission_with_expert)
    assert_equal "Nova kontaktna sprava - #{@submission_with_expert.sender_name}", mail.subject
    assert_equal [ Rails.application.config.admin_email ], mail.to
    assert_equal [ "noreply@beriembitcoin.sk" ], mail.from
    assert_match @submission_with_expert.sender_name, mail.body.encoded
  end

  test "general_contact" do
    mail = ContactMailer.general_contact(@general_submission)
    assert_equal "Vseobecna kontaktna sprava od #{@general_submission.sender_name}", mail.subject
    assert_equal [ Rails.application.config.admin_email ], mail.to
    assert_equal [ "noreply@beriembitcoin.sk" ], mail.from
    assert_match @general_submission.sender_name, mail.body.encoded
  end
end

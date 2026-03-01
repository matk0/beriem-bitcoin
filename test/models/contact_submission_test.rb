require "test_helper"

class ContactSubmissionTest < ActiveSupport::TestCase
  test "valid submission" do
    submission = ContactSubmission.new(
      sender_name: "Test User",
      sender_email: "test@example.com",
      message: "Hello, this is a test message."
    )
    assert submission.valid?
  end

  test "requires sender_name" do
    submission = ContactSubmission.new(
      sender_email: "test@example.com",
      message: "Test message"
    )
    assert_not submission.valid?
    assert_includes submission.errors[:sender_name], "nemôže byť prázdne"
  end

  test "requires sender_email" do
    submission = ContactSubmission.new(
      sender_name: "Test",
      message: "Test message"
    )
    assert_not submission.valid?
    assert_includes submission.errors[:sender_email], "nemôže byť prázdne"
  end

  test "requires message" do
    submission = ContactSubmission.new(
      sender_name: "Test",
      sender_email: "test@example.com"
    )
    assert_not submission.valid?
    assert_includes submission.errors[:message], "nemôže byť prázdne"
  end

  test "validates email format" do
    submission = ContactSubmission.new(
      sender_name: "Test",
      sender_email: "invalid",
      message: "Test message"
    )
    assert_not submission.valid?
    assert_includes submission.errors[:sender_email], "je neplatné"
  end

  test "expert association is optional" do
    submission = ContactSubmission.new(
      sender_name: "Test",
      sender_email: "test@example.com",
      message: "Test message",
      expert: nil
    )
    assert submission.valid?
  end

  test "can associate with expert" do
    expert = Expert.create!(name: "Expert", city: "City", email: "expert@test.com")
    submission = ContactSubmission.create!(
      sender_name: "Test",
      sender_email: "test@example.com",
      message: "Test message",
      expert: expert
    )
    assert_equal expert, submission.expert
  end

  test "default status is new" do
    submission = ContactSubmission.create!(
      sender_name: "Test",
      sender_email: "test@example.com",
      message: "Test message"
    )
    assert_equal "new", submission.status
  end

  test "validates status inclusion" do
    submission = ContactSubmission.new(
      sender_name: "Test",
      sender_email: "test@example.com",
      message: "Test message",
      status: "invalid_status"
    )
    assert_not submission.valid?
  end
end

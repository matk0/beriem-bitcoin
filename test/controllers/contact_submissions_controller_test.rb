require "test_helper"

class ContactSubmissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @expert = experts(:one)
  end

  test "should create general contact submission" do
    assert_difference("ContactSubmission.count") do
      post contact_submissions_url, params: {
        contact_submission: {
          sender_name: "Test User",
          sender_email: "test@example.com",
          message: "This is a test message"
        }
      }
    end

    assert_redirected_to root_url
    assert_nil ContactSubmission.last.expert
  end

  test "should create expert contact submission" do
    assert_difference("ContactSubmission.count") do
      post expert_contact_submissions_url(@expert), params: {
        contact_submission: {
          sender_name: "Test User",
          sender_email: "test@example.com",
          message: "This is a test message"
        }
      }
    end

    assert_redirected_to expert_url(@expert)
    assert_equal @expert, ContactSubmission.last.expert
  end

  test "should not create submission with invalid data" do
    assert_no_difference("ContactSubmission.count") do
      post contact_submissions_url, params: {
        contact_submission: {
          sender_name: "",
          sender_email: "",
          message: ""
        }
      }
    end

    assert_response :unprocessable_entity
  end
end

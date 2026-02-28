require "test_helper"

class Admin::ContactSubmissionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @admin = admins(:admin)
    @submission = contact_submissions(:one)
  end

  test "should redirect to login when not authenticated" do
    get admin_contact_submissions_url
    assert_redirected_to new_admin_session_url
  end

  test "should get index when authenticated" do
    sign_in @admin
    get admin_contact_submissions_url
    assert_response :success
  end

  test "should filter by status" do
    sign_in @admin
    get admin_contact_submissions_url(status: "new")
    assert_response :success
  end

  test "should show submission" do
    sign_in @admin
    get admin_contact_submission_url(@submission)
    assert_response :success
  end

  test "should update submission status" do
    sign_in @admin
    patch admin_contact_submission_url(@submission), params: {
      contact_submission: {
        status: "replied"
      }
    }

    assert_redirected_to admin_contact_submissions_url
    @submission.reload
    assert_equal "replied", @submission.status
  end
end

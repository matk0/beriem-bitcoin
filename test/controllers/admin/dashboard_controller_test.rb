require "test_helper"

class Admin::DashboardControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @admin = admins(:admin)
  end

  test "should redirect to login when not authenticated" do
    get admin_root_url
    assert_redirected_to new_admin_session_url
  end

  test "should get index when authenticated" do
    sign_in @admin
    get admin_root_url
    assert_response :success
  end
end

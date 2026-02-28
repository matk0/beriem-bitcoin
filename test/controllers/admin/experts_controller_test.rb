require "test_helper"

class Admin::ExpertsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @admin = admins(:admin)
    @expert = experts(:one)
  end

  test "should redirect to login when not authenticated" do
    get admin_experts_url
    assert_redirected_to new_admin_session_url
  end

  test "should get index when authenticated" do
    sign_in @admin
    get admin_experts_url
    assert_response :success
  end

  test "should get new when authenticated" do
    sign_in @admin
    get new_admin_expert_url
    assert_response :success
  end

  test "should create expert" do
    sign_in @admin
    assert_difference("Expert.count") do
      post admin_experts_url, params: {
        expert: {
          name: "New Expert",
          city: "Trnava",
          email: "new@example.com",
          bio: "New expert bio"
        }
      }
    end

    assert_redirected_to admin_experts_url
  end

  test "should get edit when authenticated" do
    sign_in @admin
    get edit_admin_expert_url(@expert)
    assert_response :success
  end

  test "should update expert" do
    sign_in @admin
    patch admin_expert_url(@expert), params: {
      expert: {
        name: "Updated Name"
      }
    }

    assert_redirected_to admin_experts_url
    @expert.reload
    assert_equal "Updated Name", @expert.name
  end

  test "should destroy expert" do
    sign_in @admin
    assert_difference("Expert.count", -1) do
      delete admin_expert_url(@expert)
    end

    assert_redirected_to admin_experts_url
  end
end

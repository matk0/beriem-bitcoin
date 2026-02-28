require "test_helper"

class ExpertsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @expert = experts(:one)
  end

  test "should get index" do
    get experts_url
    assert_response :success
  end

  test "should filter experts by city" do
    get experts_url(city: "Bratislava")
    assert_response :success
  end

  test "should show active expert" do
    get expert_url(@expert)
    assert_response :success
  end

  test "should redirect when showing inactive expert" do
    inactive = experts(:inactive)
    get expert_url(inactive)
    assert_redirected_to experts_url
  end
end

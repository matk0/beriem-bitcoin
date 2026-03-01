require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_url
    assert_response :success
  end

  test "should get bitcoin" do
    get bitcoin_url
    assert_response :success
  end

  test "should get faq" do
    get faq_url
    assert_response :success
  end

  test "should get navody" do
    get navody_url
    assert_response :success
  end

  test "should get navod" do
    get navod_url(slug: "zaciatok")
    assert_response :success
  end
end

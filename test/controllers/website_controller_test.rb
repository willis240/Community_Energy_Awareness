require "test_helper"

class WebsiteControllerTest < ActionDispatch::IntegrationTest
  test "should get Index" do
    get website_Index_url
    assert_response :success
  end
end

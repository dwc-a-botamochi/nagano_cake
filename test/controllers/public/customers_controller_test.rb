require "test_helper"

class Public::CustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get resources" do
    get public_customers_resources_url
    assert_response :success
  end
end

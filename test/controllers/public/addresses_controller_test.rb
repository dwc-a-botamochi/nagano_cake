require "test_helper"

class Public::AddressesControllerTest < ActionDispatch::IntegrationTest
  test "should get resource" do
    get public_addresses_resource_url
    assert_response :success
  end
end

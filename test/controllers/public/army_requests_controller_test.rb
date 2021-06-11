require 'test_helper'

class Public::ArmyRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_army_requests_new_url
    assert_response :success
  end

end

require 'test_helper'

class Admin::ArmyRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_army_requests_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_army_requests_show_url
    assert_response :success
  end

end

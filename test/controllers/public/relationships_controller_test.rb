require 'test_helper'

class Public::RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get followed" do
    get public_relationships_followed_url
    assert_response :success
  end
end

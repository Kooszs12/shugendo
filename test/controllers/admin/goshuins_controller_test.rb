require "test_helper"

class Admin::GoshuinsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get admin_goshuins_edit_url
    assert_response :success
  end
end

require "test_helper"

class User::GoshuinsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_goshuins_new_url
    assert_response :success
  end

  test "should get index" do
    get user_goshuins_index_url
    assert_response :success
  end

  test "should get show" do
    get user_goshuins_show_url
    assert_response :success
  end

  test "should get edit" do
    get user_goshuins_edit_url
    assert_response :success
  end
end

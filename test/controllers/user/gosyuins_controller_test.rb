require "test_helper"

class User::GosyuinsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_gosyuins_new_url
    assert_response :success
  end

  test "should get index" do
    get user_gosyuins_index_url
    assert_response :success
  end

  test "should get show" do
    get user_gosyuins_show_url
    assert_response :success
  end

  test "should get edit" do
    get user_gosyuins_edit_url
    assert_response :success
  end
end

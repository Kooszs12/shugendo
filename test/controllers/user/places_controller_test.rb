require "test_helper"

class User::PlacesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_places_new_url
    assert_response :success
  end

  test "should get index" do
    get user_places_index_url
    assert_response :success
  end

  test "should get show" do
    get user_places_show_url
    assert_response :success
  end

  test "should get edit" do
    get user_places_edit_url
    assert_response :success
  end
end

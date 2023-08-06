require "test_helper"

class Admin::PlacesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_places_new_url
    assert_response :success
  end

  test "should get index" do
    get admin_places_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_places_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_places_edit_url
    assert_response :success
  end
end

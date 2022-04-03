require 'test_helper'

class AnnouncementControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get announcement_index_url
    assert_response :success
  end

  test "should get create" do
    get announcement_create_url
    assert_response :success
  end

  test "should get show" do
    get announcement_show_url
    assert_response :success
  end

end

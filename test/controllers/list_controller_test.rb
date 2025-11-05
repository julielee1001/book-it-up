require "test_helper"

class ListControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(
      first_name: "Test",
      last_name: "User",
      username: "testusername",
      email: "test@example.com",
      password: "password"
    )
    sign_in @user
  end
  test "should get index" do
    get lists_path
    assert_response :success
  end

  test "should get show" do
    list = List.create!(name: "Example List", status: 1, user: @user)
    get list_url(list)
    assert_response :success
  end
end

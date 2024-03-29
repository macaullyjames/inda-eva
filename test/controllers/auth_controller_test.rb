require 'test_helper'

class AuthControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get auth_login_url
    assert_response :success
  end

  test "should get logout" do
    get auth_logout_url
    assert_response :success
  end

  test "should get org" do
    get auth_org_url
    assert_response :success
  end

  test "should get orgs" do
    get auth_orgs_url
    assert_response :success
  end

end

require "test_helper"

class MainAccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get account" do
    get main_accounts_account_url
    assert_response :success
  end
end

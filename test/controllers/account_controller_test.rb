require 'test_helper'

class AccountControllerTest < ActionDispatch::IntegrationTest

  test "should get Activations" do
    get account_Activations_url
    assert_response :success
  end

end

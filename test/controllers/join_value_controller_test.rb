require 'test_helper'

class JoinValueControllerTest < ActionController::TestCase
  test "should get results_simulations" do
    get :results_simulations
    assert_response :success
  end

end

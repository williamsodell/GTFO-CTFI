require 'test_helper'

class CountdownsControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, :name => 'fake'
    assert_response :success
  end

end

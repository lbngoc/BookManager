require 'test_helper'

class ScaffoldControllerTest < ActionController::TestCase
  test "should get Authors" do
    get :Authors
    assert_response :success
  end

end

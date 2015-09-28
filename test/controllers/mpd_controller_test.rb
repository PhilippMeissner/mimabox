require "test_helper"

describe MpdController do
  it "should get help" do
    get :help
    assert_response :success
  end

end

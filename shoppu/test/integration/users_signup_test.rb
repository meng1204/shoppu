require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    # @user = users(:UserTwo)
  end

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: {
                               email: "user@invalid",
                               birthdate: "2013-11-11",
                               address: "sfu",
                               is_moderator: "true",
                               first_name: "",
                               last_name: "",
                               password:              "foo",
                               password_confirmation: "bar" }
    end
    assert_template 'users/new'
  end

  test "valid signup information" do
    get signup_path
    post users_path, user: { username: "new_user",
                             email: "new_user@domain.com",
                             address: "SFU Burnaby, BC, Canada",
                             is_moderator: true,
                             first_name: "Rich",
                             last_name: "Shapero",
                             birthdate: "1973-11-11",
                             password: "password123",
                             password_confirmation: "password123" }
    follow_redirect!
    assert_template 'users/show'
  end
end

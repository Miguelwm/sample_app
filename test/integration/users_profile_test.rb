require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
    @user.update_attribute(:admin, true)
    @nonadmin = users(:archer)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    if @user.admin?
      assert_select 'h1', text: ("Admin | " + @user.name)
    else
      assert_select 'h1', text: @user.name
    end
    assert_select 'h1>img.gravatar'
    assert_match @user.microposts.count.to_s, response.body
    assert_select 'div.pagination'
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
  end

  test "admin tag displays properly" do
    get user_path(@user)
    assert_select 'h1', text: ("Admin | " + @user.name)
    get user_path(@nonadmin)
    assert_select 'h1', text: @nonadmin.name
  end

end

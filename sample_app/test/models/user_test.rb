require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup 
  	@user = User.new(name: "temp", email: "temp@mail.com")
  end

  test "should be valid" do
  	assert @user.valid?
  end

  test "name should be present" do
  	@user.name = "   "
  	assert_not @user.valid?
  end

  test "email should be present" do
  	@user.email = "   "
  	assert_not @user.valid?
  end

  test "length of name should be no longer than 50 char" do
  	@user.name = "a" * 51
  	assert_not @user.valid?
  end

  test "length of email should be no longer than 50 char" do
  	@user.email = "a" * 51
  	assert_not @user.valid?
  end

  test "email: accepts valid emails" do
  	valid_emails = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
  	valid_emails.each do |x|
  		@user.email = x
  		assert @user.valid?, "#{x.inspect} should be valid"
  	end
  end

  test "email: doesn't accept valid emails" do
  	valid_emails = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
  	valid_emails.each do |x|
  		@user.email = x
  		assert_not @user.valid?, "#{x.inspect} should be valid"
  	end
  end

  test "email: should be UNIQUE" do
  	temp_user = @user.dup
    @user.save
    assert_not temp_user.valid?
  end
end

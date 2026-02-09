require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "validations" do
    user = User.new
    assert_not user.valid?
    assert_includes user.errors[:name], "can't be blank"
    assert_includes user.errors[:email], "can't be blank"

    user.name = "Alice"
    user.email = "alice@example.com"
    assert user.valid?
  end

  test "associations" do
    reflection = User.reflect_on_association(:posts)
    assert_equal :has_many, reflection.macro

    reflection = User.reflect_on_association(:comments)
    assert_equal :has_many, reflection.macro
  end
end

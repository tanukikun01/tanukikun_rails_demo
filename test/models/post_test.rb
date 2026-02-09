require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "validations" do
    post = Post.new
    assert_not post.valid?
    assert_includes post.errors[:title], "can't be blank"
    assert_includes post.errors[:body], "can't be blank"
    assert_includes post.errors[:user], "must exist"

    post.title = "Hello"
    post.body = "Body"
    post.user = users(:one)
    assert post.valid?
  end

  test "associations" do
    assert_equal :belongs_to, Post.reflect_on_association(:user).macro
    assert_equal :has_many, Post.reflect_on_association(:comments).macro
  end
end

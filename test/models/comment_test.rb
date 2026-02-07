require "test_helper"

class CommentTest < ActiveSupport::TestCase
  test "validations" do
    comment = Comment.new
    assert_not comment.valid?
    assert_includes comment.errors[:body], "can't be blank"
    assert_includes comment.errors[:user], "must exist"
    assert_includes comment.errors[:post], "must exist"

    comment.body = "Nice"
    comment.user = users(:one)
    comment.post = posts(:one)
    assert comment.valid?
  end

  test "associations" do
    assert_equal :belongs_to, Comment.reflect_on_association(:user).macro
    assert_equal :belongs_to, Comment.reflect_on_association(:post).macro
  end
end

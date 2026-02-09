require "test_helper"

class LikeTest < ActiveSupport::TestCase
  test "user can like a post" do
    like = Like.new(user: users(:one), likeable: posts(:one))
    assert like.valid?
  end

  test "user can like a comment" do
    like = Like.new(user: users(:one), likeable: comments(:one))
    assert like.valid?
  end

  test "user cannot like same post twice" do
    Like.create!(user: users(:one), likeable: posts(:one))
    dup = Like.new(user: users(:one), likeable: posts(:one))
    assert_not dup.valid?
  end

  test "user cannot like same comment twice" do
    Like.create!(user: users(:one), likeable: comments(:one))
    dup = Like.new(user: users(:one), likeable: comments(:one))
    assert_not dup.valid?
  end
end

require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  test "creates like successfully" do
    assert_difference("Like.count", 1) do
      post likes_url, params: { like: { user_id: users(:two).id, likeable_type: "Post", likeable_id: posts(:one).id } }
    end
    assert_redirected_to posts_url
  end

  test "duplicate post does not create second record" do
    Like.create!(user: users(:two), likeable: posts(:one))

    assert_no_difference("Like.count") do
      post likes_url, params: { like: { user_id: users(:two).id, likeable_type: "Post", likeable_id: posts(:one).id } }
    end
    assert_redirected_to posts_url
  end
end

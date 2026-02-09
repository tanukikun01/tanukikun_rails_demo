require "test_helper"

class PostsFlowTest < ActionDispatch::IntegrationTest
  test "listing posts" do
    get posts_url
    assert_response :success
    assert_match posts(:one).title, @response.body
  end

  test "showing a post with its comments" do
    get post_url(posts(:one))
    assert_response :success
    assert_match posts(:one).title, @response.body
    assert_match comments(:one).body, @response.body
  end

  test "creating a post" do
    assert_difference("Post.count", 1) do
      post posts_url, params: {
        post: {
          title: "New title",
          body: "New body",
          user_id: users(:one).id
        }
      }
    end

    assert_redirected_to post_url(Post.order(:created_at).last)
  end

  test "creating a comment" do
    assert_difference("Comment.count", 1) do
      post comments_url, params: {
        comment: {
          body: "Great!",
          user_id: users(:two).id,
          post_id: posts(:one).id
        }
      }
    end

    assert_redirected_to post_url(posts(:one))
  end
end

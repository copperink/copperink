class API::V1::PostsController < API::V1::BaseController
  before_action :authenticate!


  # Return all posts for the user
  def index
    render json: { posts: current_user.posts.all.map(&:to_h) }
  end



  # Create new Post
  def create
    post = Post.new(
      author:     current_user,
      content:    post_params[:content],
      account_id: post_params[:account_id],
      post_at:    datetime(post_params[:post_at])
    )

    if post.save
      render json: { post: post.to_h }
    else
      render_object_errors(post)
    end
  end



  # Destroy a Post
  def destroy
    post = Post.find(params[:id])

    if post.destroy
      render json: success
    else
      render_object_errors(post)
    end
  end



  private

  def post_params
    params.require(:post).permit(:content, :post_at, :account_id)
  end

  def datetime(timestamp)
    Time.at(timestamp.to_i).to_datetime
  end

end

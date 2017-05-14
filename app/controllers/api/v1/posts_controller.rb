class API::V1::PostsController < API::V1::BaseController
  before_action :authenticate!


  # Return all posts for the user
  def index
    render json: { posts: current_user.posts.all.map(&:to_h) }
  end



  # Create new Post
  def create
    post = Post.new(post_params)

    if post.save
      ImageAttachment.create!(imageable: post, data: image) if image.present?
      render json: { post: post.to_h }
    else
      render_object_errors(post)
    end
  end


  # Update a post
  def update
    post = Post.find(params[:id])

    if post.update(post_params)
      render json: { post: post.to_h }
    else
      render_object_errors
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
    attrs = params.require(:post).permit(:content, :post_at, :account_id)

    {
      author:     current_user,
      content:    attrs[:content],
      account_id: attrs[:account_id],
      post_at:    datetime(attrs[:post_at])
    }
  end

  def image
    params[:image_data]
  end

  def datetime(timestamp)
    Time.at(timestamp.to_i).to_datetime
  end

end

class PostsController < ApplicationController
  def index
    @posts = Post.all
    @post = Post.new
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def create
    @post = Post.new(post_params)
    @post.save!
    
    redirect_to action: :index
  end
  
  def update
    
  end
  
  def destroy
    Post.destroy(params[:id])
  end
  
  private
  
  def post_params
    params.require(:post).permit(:user_id, :content)
  end
end

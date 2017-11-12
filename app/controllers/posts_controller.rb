class PostsController < ApplicationController
  def index
    @posts = Post.all
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def create
    @post = Post.new(params[:user_id], params[:content])
    @post.save!
  end
  
  def update
    
  end
  
  def destroy
    Post.destroy(params[:id])
  end
end

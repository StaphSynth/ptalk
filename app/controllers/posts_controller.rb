class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  def index
    @posts = Post.all
    @post = Post.new
  end

  def show
  end

  def create
    @post = Post.new(post_params)
    @post.save!
    redirect_to action: :index
  end

  def edit
  end

  def update
    @post.update_attributes(post_params)
    redirect_to action: :index
  end

  def destroy
    @post.destroy
    redirect_to action: :index
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :content)
  end

  def set_user
    @user ||= current_user
  end

  def set_post
    @post ||= Post.find(params[:id])
  end
end

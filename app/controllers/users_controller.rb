class UsersController < ApplicationController
  before_action :require_login, only: %i[show edit index]
  before_action :user, only: %i[show edit]

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = 'Successful signup!'
    else
      flash[:error] = 'Oops, an error occured. Please try again later.'
    end

    redirect_to root_path
  end

  def show
  end

  def edit
  end

  def index
    @users = User.all
  end

  private

  def user_params
    params.require(:user).permit(:id, :name, :email, :password)
  end

  def user
    @user ||= User.find(params[:id])
  end
end

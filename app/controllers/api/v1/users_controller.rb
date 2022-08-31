class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  before_action :find_user, only: [:show, :destroy]  
  
  def index
    @users = User.all          
    render json: @users, status: :ok
  end
  
  
  def create
    @user = User.create(user_params)
    if @user.save
      
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_message},
             status: :unprocessable_entity
    end
  end
  
  def show
    render json: @user, status: :ok
  end
  
  
  def update
    unless @user.update(user_params)
      render json: {errors: @user.errors.full_message},
             status: :unprocessable_entity
    end
  end
  
  def destroy
    @user.destroy
  end  

  private
  def user_params
    params.permit(:username, :email, :password_digest)
  end

  def find_user
    @user = User.find(params[:id])
  end
end

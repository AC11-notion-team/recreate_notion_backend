class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:email_present, :create, :email_confirmed ]
  before_action :find_user, only: [:show, :destroy, :login, :email_present, :email_confirmed]  
  
  def index
    @users = User.all          
    render json: @users, status: :ok
  end
  
  def email_present
    if User.find_by_email(params[:email]).present?
      if is_third_party_sign_up
        render json: { :message => "user already exists, please press google account bottom"}  
      else
        render json: { :message => "user already exists, password, please!  => GET url: /api/v1/users/login"}
      end
    else
      render json: { :message => "new user need create ! => POST url: /api/v1/users"}
    end
  end


  def create
      @user = User.create!(user_params)
      UserMailer.registration_confirmation(@user).deliver_now
      render json: { :user_id => @user.id, :message => "Please confirm your email address to continue => GET url:  /api/v1/users/email_confirmed" }
  
  end

  def email_confirmed
    if params[:confirm_token] == @user[:confirm_token]
      @user.email_activate
      # login
      token = jwt_encode(user_id: @user.id)

      render json: {:message => "Welcome to the Zettel! Your email has been confirmed.",
        :user_id => @user.id }
    else
      render json: {:message => "Sorry. User does not exist"} 
    end
  end

  def login
    if User.find_by(password_digest: params[:password]) && User.find_by(email_confirmed: true)
      token = jwt_encode(user_id: @user.id)
      render json: {:message => "log in successfully!",
        :auth_token => token,
        :user_id => @user.id }, status: :ok
    else
      render json: { :message => "wrong password! "}
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
    params.permit(:username, :email, :password)
    
  end

  def find_user
    @user = User.find_by_email(params[:email])
  end

  def is_third_party_sign_up
    @user[:third_party] == true
  end
end

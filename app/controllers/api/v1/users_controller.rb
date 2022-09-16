class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[email_present create email_confirmed login]
  before_action :find_user, only: %i[show destroy login email_present email_confirmed]

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def email_present
    user = User.find_by_email(params[:email])
    if user.nil?
      render json: { "status": 'register', "message": 'new user need create ! => POST url: /api/v1/users' }
    elsif @user[:third_party] == true
      render json: { "status": 'third', "message": 'user already exists, please press google account bottom' }
    elsif user.email_confirmed == true
      render json: { "status": 'login',
                     "message": 'user already exists, password, please!  => GET url: /api/v1/users/login' }
    elsif user.email_confirmed.nil?
      UserMailer.registration_confirmation(@user).deliver_now
      render json: { "status": 'unvertify' }
    end
  end

  def create
    @user = User.create!(user_params)
    UserMailer.registration_confirmation(@user).deliver_now
    render json: { "status": 'unvertify',
                   "message": 'Please confirm your email address to continue => GET url:  /api/v1/users/email_confirmed' }
  end

  def email_confirmed
    if params[:confirm_token] == @user[:confirm_token]
      @user.email_activate
      @user.pages.create!
      render json: { "status": 'login', "message": 'Welcome to the Zettel! Your email has been confirmed. GET url: /api/v1/users/login',
                     "user_id": @user.id }

    else
      render json: { "status": 'unvertify', "message": 'Sorry. User does not exist' }
    end
  end

  def login
    if @user.authenticate(params[:password])
      create_token
    else
      render json: { "status": 'login', "message": 'password wrong' }
    end
  end

  def show
    @pages = @current_user.pages
    # render json: @user, status: :ok
  end

  def update
    unless @user.update(user_params)
      render json: { "errors": @user.errors.full_message },
             status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  def search_user 
    if !params[:search].empty?
      @users = User.where("email like ?", "%#{params[:search]}%")
    end
  end

  private

  def user_params
    params.permit(:username, :email, :password)
  end

  def find_user
    @user = User.find_by_email(params[:email])
  end
end

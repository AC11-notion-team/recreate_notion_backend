class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[email_present create email_confirmed login third_party_login]
  before_action :find_user, only: %i[show login email_present email_confirmed third_party_login]

  def email_present
    if @user.nil?
      render json: {
        status: 'register',
        message: 'new user need create!'
      } and return
    end

    if @user[:third_party]
      render json: {
        status: 'third',
        message: 'user already exists, please press google account bottom'
      } and return
    end

    if @user.email_confirmed
      render json: {
        status: 'login',
        message: 'user already exists, password, please!'
      } and return
    end

    if @user.email_confirmed.nil?
      UserMailer.registration_confirmation(@user).deliver_now
      render json: { status: 'unvertify' }
    end
  end

  def create
    user = User.create!(user_params)
    UserMailer.registration_confirmation(user).deliver_now
    render json: {
      status: 'unvertify',
      message: 'Please confirm your email address to continue'
    }
  end

  def email_confirmed
    if params[:confirm_token] == @user[:confirm_token]
      @user.email_activate
      render json: {
        status: 'login',
        message: 'Welcome to the Zettel! Your email has been confirmed.',
        user_id: @user.id
      }
    else
      render json: { status: 'unvertify', message: 'Sorry. User does not exist' }
    end
  end

  def login
    if @user.authenticate(params[:password])
      create_token_for(@user)
    else
      render json: { status: 'login', message: 'password wrong' }
    end
  end

  def third_party_login
    if @user
      create_token_for(@user)
    else
      @user = build_third_party_user_with(params)

      if @user.save
        @user.pages.create!
        create_token_for(@user)
      else
        render json: { message: 'wrong key' }
      end
    end
  end

  def show
    user = User.find_by(email: params[:email])
    @pages = @current_user.pages.order('created_at ASC')
    @pages = @pages.map do |page|
      page.shareuser = page.users.select { |user| user != @current_user }
      page
    end
  end

  def search_page
    unless params[:search].empty?
      @pages = @current_user.pages.where("title Ilike?","%#{params[:search]}%")
    end
  end
  
  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_message },
             status: :unprocessable_entity
    end
  end

  def search_user
    page = Page.find(params[:page_id])
    unless params[:search].empty?
      @users = User.where('email like ?', "%#{params[:search]}%")
      @Users = @users.select { |user| p !page.users.include?(user) }
      @Users
    end
  end

  def trash_page
    @trans_pages = @current_user.pages.only_deleted.order('deleted_at ASC')
  end

  def restore_page
    id = params[:restorePageId]
    restore_page=Page.find(id) if @current_user.pages.restore(id, :recursive => true)
    render json: restore_page
  end

  private

  def user_params
    params.permit(:username, :email, :password)
  end

  def find_user
    @user = User.find_by(email: params[:email])
  end

  def build_third_party_user_with(data)
    User.new(
      username: data[:name],
      email: data[:email],
      password: data[:email], 
      third_party: true
    )
  end
end

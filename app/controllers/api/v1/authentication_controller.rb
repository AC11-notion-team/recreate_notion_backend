class Api::V1::AuthenticationController < ApplicationController
  skip_before_action :authenticate_request
  def login
    if @user = User.find_by_email(params[:email])
      token = jwt_encode(user_id: @user.id)
      create_token
    else
      p "1-"*100
      p params
      p "-" *100
      @user = User.new(username: params[:authentication][:name] ,email:params[:authentication][:email] )  
      p @user
      p "2-" *100
      @user.save
      p User.last
      p "-" *100
      create_token
    end
  end 

  private
  def create_token
    token = jwt_encode(user_id: @user.id)
      render json: {:message => "Ok",
                    :auth_token => token,
                    :user_id => @user.id }, status: :ok
  end
end

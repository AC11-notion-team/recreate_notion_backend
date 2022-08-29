class Api::V1::AuthenticationController < ApplicationController
  skip_before_action :authenticate_request
  def login
    @user = User.find_by_email(params[:email])
    if  @user&.authenticate(params[:password])
      token = jwt_encode(user_id: @user.id)
      render json: {:message => "Ok",
                    :auth_token => token,
                    :user_id => @user.id }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
  def logout
    @user = User.find_by_email(params[:email])
    
  end
end

class ApplicationController < ActionController::API
  include JsonWebToken

  before_action :authenticate_request
  
  private
  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(" ").last if header
    decode = jwt_decode(header)
    @current_user = User.find(decode[:user_id])
  end

  def create_token
    token = jwt_encode(user_id: @user.id)
    render json: {:message => "Log in, successfully!",
      :auth_token => token,
      :user_id => @user.username,
      :user_image=> @user.image }, status: :ok
  end
end

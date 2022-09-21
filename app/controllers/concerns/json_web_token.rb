require "jwt"

module JsonWebToken
  SECRET_KEY = Rails.application.secret_key_base

  def jwt_encode(payload, exp = 1.days.from_now)
    payload[:exp] =  exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def jwt_decode(token)
    decode = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decode
  end

  def create_token_for(user)
    token = jwt_encode(user_id: user.id)
    render json: { 
      status: 'success', message: 'Log in, successfully!',
      auth_token: token,
      user_id: user.username,
      user_image: user.image,
      user_email: user.email }, status: :ok
  end
end
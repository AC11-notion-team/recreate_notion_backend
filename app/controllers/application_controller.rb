class ApplicationController < ActionController::API
  before_action :authenticate_request

  def have_permission?(page, user)
    page = Page.find_by(id: params[:page_id])
    render status: 404 if page.editable.nil?
    render status: 404 if page.users.includes?(@current_user)
  end

  private

  include JsonWebToken

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decode = jwt_decode(header)
    @current_user = User.find(decode[:user_id])
  end

  
end

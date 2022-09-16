module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include JsonWebToken

    identified_by :authenticate_request

    def connect
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      decode = jwt_decode(header)
      User.find(decode[:user_id])
    end
  end
end

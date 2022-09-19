class PageChannel < ApplicationCable::Channel
  def subscribed
    id = params['id']
    stream_from "page_#{id}"
  end
end

class PageChannel < ApplicationCable::Channel
  def subscribed
    page = Page.find(params[:id])
    stream_for page
  end
end

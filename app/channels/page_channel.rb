class PageChannel < ApplicationCable::Channel
  def subscribed
    p '<' * 50
    p a = params['id']
    p '?' * 50

    # page = Page.find(a)
    stream_from "page_#{a}"
  end
end

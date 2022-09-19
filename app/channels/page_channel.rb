class PageChannel < ApplicationCable::Channel
  def subscribed
    # stream_from method
    # id = params['id']
    # stream_from "page_#{id}"
    # ActionCable.server.broadcast("page_#{id}", { message: 'success' })

    #stream_for method
    @page = Page.find(params['id'])
    stream_for @page
    PageChannel.broadcast_to(@page, message: {text: 'sendback', data: { id: 'aaa' }})
  end

  def logSomething(text)
    p text
    PageChannel.broadcast_to(@page, message: {text: 'sendback', data: { id: 'aaa' }})
  end


end

class Api::V1::PagesController < ApplicationController
  before_action :authenticate_request

  def index
    @pages = current_user.pages
  end

  def create
    page = Page.create(
      "icon": params[:icon],
      "cover": params[:cover]
    )
    if page.save
      Sharepage.create!(user_id: @current_user.id, page_id: page.id, editable: :ture)
      render json: page
    else
      render json: { message: "cann't save the page" }
    end
  end

  def update
    @page = Page.find(params[:id])

    if params[:title]
      @page.update(title: params[:title])
    else
      @page.update(icon: params[:icon])
    end
  end

  def show
    @page = Page.find(params[:id])
    render status: 404 if !@page.users.include?(@current_user) && @page.editable.nil?
    @blocks = @page.blocks != [] ? Page.print_all_blocks(@page[:tail]) : []
  end

  def show_page_info
    @page = Page.find_by(id: params[:page_id])
  end

  def save_data
    @page = Page.find_by(id: params[:page_id])
    block_data = params[:api][:blocks]
    prev_blockID = nil
    block_data.map.with_index do |block, _index|
      @find_block = Block.where(blockID: block[:id])
      if @find_block.empty?
        @block = @page.blocks.new(
          "blockID": block[:id],
          "kind": block[:type],
          "data": block[:data],
          "prev_blockID": prev_blockID
        )
        prev_blockID = block[:id]
        @block.save
      else
        @find_block.update(
          "blockID": block[:id],
          "kind": block[:type],
          "data": block[:data],
          "prev_blockID": prev_blockID
        )
        prev_blockID = block[:id]
      end
    end
    @page.update(
      "tail": prev_blockID
    )

    ActionCable.server.broadcast("page_#{@page.id}", { page: @page })
  end

  def editable
    page = @current_user.pages.find(params[:page_id])
    page.update(
      editable: params[:state]
    )
  end

  def delete_data
    @page = Page.find_by(id: params[:page_id])
    @block = Block.find_by(blockID: params[:block_id], page_id: params[:page_id])

    if @page.tail == @block.blockID
      @page.update("tail": @block.prev_blockID)
    else
      @nextBlock = Block.find_by(prev_blockID: params[:block_id], page_id: params[:page_id])
      @nextBlock.update("prev_blockID": @block.prev_blockID)
    end
    @block.destroy
  end

  def delete_page
    page = Page.find_by(id: params[:page_id])
    page.destroy
    render json: page
  end
  
  
  private

  def page_params
    params.permit(:icon, :cover, :url)
  end
end

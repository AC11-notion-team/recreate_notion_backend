class Api::V1::PagesController < ApplicationController
  before_action :authenticate_request
  
  def index 
    @pages = Page.all
    render json:@pages
  end
  def create
    @page = @current_user.pages.create(page_params)
    if @page.save
      render json:{id: @page.id}
    else
      render json:{message:"cann't save the page"}
    end
  end

  def update
    @page = Page.find(params[:id])
    if @page.update
      render json:{message:"page #{@page.id} was update"}
    else 
      render json:{message:"page #{@page.id} couldn't update"} , status:404
    end
  end

  def show
    @page = Page.find(params[:id])
    @blocks=Page.print_all_blocks(@page[:tail])
    
  end

  def save_data
    # 先找到那一頁
    @page = Page.find_by(:id => params[:page_id])
    #對那一頁的基本資料進行更新
    @page.update(
      "title": params[:title],
      "icon": params[:icon],
      "cover": params[:cover]
    )
    block_data = params[:api][:blocks]
    prev_editorID = nil
    block_data.map.with_index do |block,index|
      @find_block = Block.where(:editorID=>block[:id])
      if @find_block.empty?
        # debugger
        @block = @page.blocks.new(
          "editorID": block[:id],
          "kind": block[:type],
          "data": block[:data],
          "prev_editorID": prev_editorID 
        )
        prev_editorID = block[:id]
        @block.save
        p "<"*50
        p "#{block[:id]} save"
        p ">" *50
      else
        @find_block.update(
          "editorID": block[:id],
          "kind": block[:type],
          "data": block[:data],
          "prev_editorID": prev_editorID 
        )
        prev_editorID = block[:id]
        p "<"*50
        p "#{block[:id]} update"
        p ">" *50
      end
    end
    @page.update(
      "tail": prev_editorID
    )
  end

  private 
  def page_params
    params.permit(:icon , :cover, :url)
  end
end


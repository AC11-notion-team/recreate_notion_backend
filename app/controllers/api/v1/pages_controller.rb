class Api::V1::PagesController < ApplicationController
  before_action :authenticate_request
  
  def index 
    @pages = current_user.pages
  end
  def create
    @page = @current_user.pages.create(
      "icon": params[:icon],
      "cover": params[:cover],
    )
    if @page.save
      @pages = @current_user.pages
      render "api/v1/pages/create.json.jbuilder"
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
    # debugger
    p ">"*50
    p params
    p"<" *50
    @page = Page.find(params[:id])
    if @page.blocks!=[]
      @blocks=Page.print_all_blocks(@page[:tail])
    end
    
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
    prev_blockID = nil
    block_data.map.with_index do |block,index|
      @find_block = Block.where(:blockID=>block[:id])
      if @find_block.empty?
        # debugger
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
  end

  def share
    @page = Page.find(params[:id])
    prev_share = @page.share
    if @page.update(:share !prev_share )
      render json:{"message":"page #{@page.id} share #{@page.shar} was update"}
    else
      render json:{"message":"page #{@page.id} share couldn't update"} , status:404
    end
  end


  private 
  def page_params
    params.permit(:icon , :cover, :url)
  end
end


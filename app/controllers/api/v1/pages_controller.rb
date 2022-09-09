class Api::V1::PagesController < ApplicationController
  # before_action :authenticate_request

  def index
    @pages = current_user.pages
  end

  def create
    @page = @current_user.pages.create(
      "icon": params[:icon],
      "cover": params[:cover]
    )
    if @page.save
      render json: @page
    else
      render json: { message: "cann't save the page" }
    end
  end

  def update
    @page = Page.find(params[:id])
    if @page.update
<<<<<<< HEAD
      render json:{message:"page #{@page[:id]} was update"}
    else 
      render json:{message:"page #{@page[:id]} couldn't update"} , status:404
=======
      render json: { message: "page #{@page.id} was update" }
    else
      render json: { message: "page #{@page.id} couldn't update" }, status: 404
>>>>>>> feature/connect_frontend_server_login
    end
  end

  def show
    @page = Page.find(params[:id])
    @blocks = Page.print_all_blocks(@page[:tail])
    if @page.blocks!=[]
      @blocks=Page.print_all_blocks(@page[:tail])
    end  
    if @current_user == @page[:user_id]
      @state = "is a current user"
    else
      share = @page[:share]
      if share 
        editable = @page[:editable]
        if editable
          @state = "can write"
        else
          @state = "can read"
        end
      else
        @state = "refuse"
      end
    end
   
  end



  def save_data
    @page = Page.find_by(id: params[:id])
    p params[:page_id]
    @page.update(
      "title": params[:title],
      "icon": params[:icon],
      "cover": params[:cover]
    )
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
  end

  def share
    @page = Page.find(params[:id])
    prev_share = @page[:share]
    
    if @page.update("share" : !prev_share ) 
      share = @page[:share]
      if share
        render json:{"message":"page" : "#{@page[:id]}", "share": "#{@page[:share]}","state": " was update"}
      else
        @page.update("editable" :false)
      end
    else
      render json:{"message":"page": "#{@page[:id]}","state": "share couldn't update"} , status:404
    end
  end

  def editable
    @page = Page.find(params[:id])
    prev_editable = @page[:editable]

    if @page.update("editable" : !prev_editable ) 
      render json:{"message":"share": "#{@page[:share]}","editable": "#{@page[:editable]}","state": "was update"}
    else
      render json:{"message":"page": "#{@page[:id]}","state": "editable couldn't update"} , status:404
    end
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

  private

  def page_params
    params.permit(:icon, :cover, :url)
  end
end

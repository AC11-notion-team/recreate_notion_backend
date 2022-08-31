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
    p "-"*100
    p params
    p "-"*100
    @page = Page.find(params[:id])
    p @page
    p "-"*100
    @blocks = @page.blocks
  end
  def save_data
    @page = Page.find_by(id: params[:page_id])
    @page.update(page_params)
    block_data = params[:api][:blocks]
    if block_data.length  == 1
      @block = @page.blocks.new(
        "editorID": block_data[0][:id],
        "kind": block_data[0][:type],
        "data": block_data[0][:data]
      )
      p @block.save
    else
      block_data.map do |block|
        p block
        @block = @page.blocks.new(
          "editorID": block[:id],
          "kind": block[:type],
          "data": block[:data]
        )
        p @block.save
      end
    end
  end

  private 
  def page_params
    params.permit(:icon , :cover, :url)
  end
  def block_params(block_data)
    block_data.params.permit(:id,:type,:data)
  end

end


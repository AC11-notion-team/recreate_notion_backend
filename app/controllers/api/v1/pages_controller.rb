<<<<<<< HEAD
class Api::V1::PagesController < ApplicationController
  before_action :authenticate_request
  
  def index 
    @pages = Page.all
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

  private 
  def page_params
    params.permit(:icon , :cover, :url)
  end

=======
class Api::V1::PagesController < ApplicationController
  
  def index 
    @pages = Page.all
  end
  def create
    @page = Page.new
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
    @blocks = @page.blocks
    render :json
  end






  private 
  def page_params
    params.require(:page).permit(:icon , :cover, :url)
  end

>>>>>>> origin/feature/user_block_page
end
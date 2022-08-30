class Api::V1::BlocksController < ApplicationController
  def index
  end
  def show
  end
  def create
    @block = Block.new(block_params)
    @block.save
    render json:params
  end
  def destroy
  end

  private
  def block_params
    params.permit(:type , :data)
  end

end

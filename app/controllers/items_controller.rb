class ItemsController < ApplicationController
  before_action :set_items, only: [:show, :edit, :update, :destroy]
  
  def index
    items = Item.all
    paginate json: items.as_json, status: :ok
  end

  def show
    render json: @item.as_json, status: :ok
  end

  def create
    firs_user = User.first
    item = firs_user.items.new(item_params)
    if item.save
      render json: item.as_json, status: :created
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def update
    if item.update(item_params)
      head :no_content
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    head :no_content
  end

  private
  
  def item_params
    params.permit(:name, :user_id)
  end

  def set_items
    @item = Item.find(params[:id])
  end
end

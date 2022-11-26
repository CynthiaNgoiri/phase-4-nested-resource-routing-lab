class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :item_not_found

  def show
    items = Item.find(params[:id])
    render json: items
  end

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items 
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def create 
    user = User.find(params[:user_id])
    user.items << Item.create(item_params)
    render json: user.items.last, status: :created

  end

  private

  def item_not_found
     render json: { error: 'Item not found'}, status: :not_found
  end

  def item_params
    params.permit(:name,:description,:price)
  end

end

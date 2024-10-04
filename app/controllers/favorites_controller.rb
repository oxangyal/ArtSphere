class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @product = Product.find(params[:product_id])
    current_user.favorites.create(product: @product)
    redirect_to @product, notice: 'Added to favorites.'
  end

  def destroy
    @product = Product.find(params[:product_id])
    favorite = current_user.favorites.find_by(product: @product)
    favorite.destroy if favorite
    redirect_to @product, notice: 'Removed from favorites.'
  end
end

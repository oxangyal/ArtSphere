class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @product = Product.find(params[:product_id])
    current_user.favorites.create(product: @product)
    redirect_back fallback_location: products_path, notice: 'Added to favorites.'
  end

  def destroy
    @product = Product.find(params[:product_id])
    favorite = current_user.favorites.find_by(product: @product)
    favorite.destroy if favorite
    redirect_back fallback_location: products_path, notice: 'Removed from favorites.'
  end

  private

  def authenticate_user!
    unless user_signed_in?
      flash[:alert] = 'You need to be registered or logged in to add favorites.'
      redirect_back(fallback_location: root_path)
    end
  end
end

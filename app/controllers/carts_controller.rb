class CartsController < ApplicationController
    before_action :set_product, only: [:create, :destroy]
    def create
      @current_cart.cart_items.create(product_id: @product.id)
    end
  
    def show
    end
  
    def destroy
      @cart_item = @current_cart.cart_items.find_by_product_id(@product.id)
      @cart_item.destroy
      redirect_to cart_path(@current_cart)
    end
  
    private
  
    def set_product
      @product = Product.find(params[:product_id])
    end
  end
class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  helper FavoritesHelper
  # GET /products or /products.json
  def index
    @products = Product.all

    @products = @products.order("#{sort_column} #{sort_direction}")
  end

  # GET /products/1 or /products/1.json
  def show
    @product = Product.find(params[:id])
    @favorite_count = @product.favorites.count
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        Rails.logger.debug @product.errors.full_messages  # Log error messages
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /products/1 or /products/1.json
  def update
    new_product_params = product_params.to_unsafe_h
    if new_product_params["images"].present? && new_product_params["images"].all?(&:blank?)
      new_product_params.delete("images")
    end
    respond_to do |format|
      if @product.update(new_product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
    params.require(:product).permit(
      :name, :price, :material, :artist_name, :original, :year, :category_id,  :description, images: []
    )
  end

    def sort_column
      Product.column_names.include?(params[:sort]) ? params[:sort] : 'name'
    end

    def sort_direction
      if params[:direction] == "asc"
        "desc"
      else
        "asc"
      end
    end

    def current_direction
      params[:direction] || "asc"
    end
end

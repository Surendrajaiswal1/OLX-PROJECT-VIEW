class SellProductsController < ApplicationController
  before_action :authenticate_user
  before_action :get_product, only: [:show, :update, :destroy]

  def new
    @product = @current_user.sell_products.new
  end

  def create
    @product = @current_user.sell_products.new(set_params)
    return render @product if @product.save
    redirect_to sell_products
  end

  def show
    render json: @product
  end

  def index
     if params[:name].present?
      name = params[:name].strip
      products = @current_user.sell_products.where("name LIKE '%#{name}%'")
      render json: products
    elsif params[:alphanumeric_id].present?
      alphanumeric_id = params[:alphanumeric_id].strip
      products = @current_user.sell_products.where("alphanumeric_id LIKE '%#{alphanumeric_id}%'")
      render json: products
    else
      all_products = @current_user.sell_products.page(params[:page])
      return render json: all_products unless all_products.empty?
      render json: {message: "NO PRODUCT AVAILABLE"}
    end
  end

  def update
    return render json: @product if @product.update(set_params)
      render json: {message: "Updation failed"}
  end

  def destroy
    return render json: @product if @product.delete
     render json: {message: "PRODUCT DELETION FAILED"}
  end

 private
    def set_params
      params.permit(:name, :price, :description, :category_id, :image)
    end

    def get_product
      @product = @current_user.sell_products.find_by(id: params[:id])
    end
end

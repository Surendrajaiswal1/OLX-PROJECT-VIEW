class SellProductsController < ApplicationController
  before_action :authenticate_user
  before_action :get_product, only: [:show, :edit, :update, :destroy]

  def new
    @product = SellProduct.new
  end

  def create
    @product = @current_user.sell_products.new(set_params)
    if @product.save
      redirect_to products_path
    else
      flash[:add] = 'Product was not added '
      render 'new_sell_product'
    end
  end

  def show
    render json: @product
  end

  def index
     if params[:name].present?
      name = params[:name].strip
      @products = @current_user.sell_products.where("name LIKE '%#{name}%'")
      # render json: products
    elsif params[:alphanumeric_id].present?
      alphanumeric_id = params[:alphanumeric_id].strip
      @products = @current_user.sell_products.where("alphanumeric_id LIKE '%#{alphanumeric_id}%'")
      # render json: products
    else
      @products = @current_user.sell_products.page(params[:page])
      # return render json: all_products unless all_products.empty?
      # render json: {message: "NO PRODUCT AVAILABLE"}
    end
  end

  def edit
  end

  def update
    unless @product.update(set_params)
      flash[:sell] = 'Updation failed'
    end
  end

  def destroy
    unless @product.delete
      flash[:sell] = 'PRODUCT DELETION FAILED'
    end
  end

 private
    def set_params
      params.require(:sell_product).permit(:name, :price, :description, :category_id, :image)
    end

    def get_product
      @product = @current_user.sell_products.find_by(id: params[:id])
    end
end

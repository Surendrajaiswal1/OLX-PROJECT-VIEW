class SellProductsController < ApplicationController
  before_action :authenticate_user
  before_action :get_product, only: [:show, :edit, :update, :destroy]

  def new
    @product = SellProduct.new
  end

  def create
    @product = @current_user.sell_products.new(set_params)
    if @product.save
      @product.available!
      redirect_to show_available_products_buy_products_path
    else
      flash[:add] = 'Product was not added '
      render 'new_sell_product'
    end
  end

  def show
    render json: @product
  end

  def index
     if params[:choice] == "name" && params[:name].present?
      name = params[:name].strip
      @products = @current_user.sell_products.where("name LIKE '%#{name}%'")
      # render json: products
    elsif params[:choice] == "alphanumeric_id" && params[:alphanumeric_id].present?
      alphanumeric_id = params[:alphanumeric_id].strip
      @products = @current_user.sell_products.where("alphanumeric_id LIKE '%#{alphanumeric_id}%'")
    else
      @products = @current_user.sell_products.page(params[:page])
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

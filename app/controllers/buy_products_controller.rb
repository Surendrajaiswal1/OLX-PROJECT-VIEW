class BuyProductsController < ApplicationController
  before_action :authenticate_user

  def show_available_products
    if params[:choice] == "name" && params[:name].present?
      name = params[:name].strip
      @products = SellProduct.joins(:category).where("name like '%#{name}%'")
    elsif params[:choice] == "category" && params[:category_name].present?
      category_name = params[:category_name].strip
      @products = SellProduct.joins(:category).where("category_name like '%#{category_name}%'")
    else
      @products = SellProduct.available
    end
  end

  # def show_data_category_wise
  #   show_products =  Category.all
  #   render json: show_products
  # end

  def buy
    @product = @current_user.buy_products.new(sell_product_id: params[:id])
    product_data = SellProduct.find_by(id: params[:id])
    if product_data.status == 'sold'
      flash[:buy] = 'Product in no more available'
      redirect_to show_available_products_buy_products_path
    else
      @product.save
      product_data.sold!
    end
  end

  def index
    @product = @current_user.buy_products
  end

end

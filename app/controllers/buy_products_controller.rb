class BuyProductsController < ApplicationController
  before_action :authenticate_user

  def show_available_products
    if params[:name].present?
      name = params[:name].strip
      @products = SellProduct.joins(:category).where("name like '%#{name}%'")
      # return render json: search_products if search_products.present?
      # render json: {message: "NO SUCH PRODUCT EXIST"}
    elsif params[:category_name].present?
      category_name = params[:category_name].strip
      @products = SellProduct.joins(:category).where("category_name like '%#{category_name}%'")
      # return render json: search_products if search_products.present?
      # render json: {message: "NO SUCH PRODUCT EXIST"}
    else
      @products = SellProduct.all
    end
  end

  def show_data_category_wise
    show_products =  Category.all
    render json: show_products
  end

  def new
    @buy_product = @current_user.buy_products.new
  end

  def create
    @buy_product = @current_user.buy_products.new(set_params)
    product_data = SellProduct.find_by(id: params[:sell_product_id])
    return render json: {message: "Product is OUT OF STOCK"} if product_data.status == 'sold' || @current_user.id == product_data.user_id
    @buy_product.save
    render json: @buy_product
  end

  def index
    search_product = @current_user.buy_products.find_by(id: params[:id])
    return render json: search_product if search_product.present?
    purchase_product = @current_user.buy_products
    return render json: purchase_product if purchase_product.present?
    render json: {message: "ORDER HISTORY IS EMPTY"}
  end

  def update_status(product_id)
    change_status = SellProduct.find(product_id)
    change_status = change_status.update(status: 'sold')
  end

  private

  def set_params
    params.permit(:contact_number, :sell_product_id)
  end

  # rescue_from ActionController::Redirecting::UnsafeRedirectError do
  # redirect_to '/products'
  # end
end

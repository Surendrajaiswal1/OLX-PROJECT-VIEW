class CategoriesController < ApplicationController
  before_action :authenticate_user

  def index
    @categories = Category.all
  end

  def show
   @products = SellProduct.joins(:category).available.merge(Category.where(id:params[:id]))
  end

end

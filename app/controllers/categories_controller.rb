class CategoriesController < ApplicationController
  before_action :get_category, only: [:update, :destroy]

  def index
    categories = Category.all

    if categories
      render json: categories
    else
      render json: {message: "No category found"}
    end
  end

  def create
    create_category = Category.new(set_params)
    return render json: create_category if create_category.save
      render json: {error: "No category created"}
  end

  def update
    return render json: @category if @category.update(set_params)
    render json: {message: "Updation failed"}
  end

  def destroy
    return render json: @category if @category.destroy
    render json: {message: "Category deletion failed"}
  end

  private

    def set_params
      params.permit(:category_name)
    end

    def get_category
      @category = Category.find_by(id: params[:id])
      render json: {message: "CATEGORY NOT FOUND"} unless @category.present?
    end
end

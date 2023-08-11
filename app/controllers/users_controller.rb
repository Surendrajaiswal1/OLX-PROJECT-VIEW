class UsersController < ApplicationController
  before_action :authenticate_user, only: [:edit, :show, :update, :destroy]
  before_action :get_user, only: [:edit,:show, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(set_params)
    return redirect_to login_path if @user.save
    render 'new'
  end

  def login
    @user = User.find_by(email: params[:email], password: params[:password])
    # debugger
    if @user.present?
      session[:current_user] = jwt_encode(user_id: @user.id)
      redirect_to @user
    else
      render "users/signin", status: :unauthorized
    end
  end

  def signin
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    session.delete(:current_user)
    @current_user = nil
    flash[:notice] = "Account Deleted"
    redirect_to new_user_path
  end

  def edit
  end

  def update
    if @user.update(set_params)
      flash[:notice] = "Successfully Password Was Change"
      redirect_to @user
    end
  end

  private

  def set_params
    params.require(:user).permit(:name, :email, :password)
  end

  def get_user
    @user = User.find_by(id: params[:id])
  end
end

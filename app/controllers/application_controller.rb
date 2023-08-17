class ApplicationController < ActionController::Base
  include JsonWebToken

  def authenticate_user
    begin
      decoded = jwt_decode(session[:current_user].split(' ').last)
      @current_user = User.find(decoded[:user_id])
      raise unless @current_user.present?
     rescue StandardError
     # flash[:notice] = "First Login Yourself"
     # redirect_to login_path
    end
  end
end

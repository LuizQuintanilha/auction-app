class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_blocked_user
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:cpf])
  end

  def check_blocked_user
    if user_signed_in? && current_user.blocked?
      flash.now[:notice] = "Sua conta está suspensa."
      sign_out current_user
      redirect_to new_user_session_path
    end
  end

end

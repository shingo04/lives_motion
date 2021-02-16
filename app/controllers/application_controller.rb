class ApplicationController < ActionController::Base
  before_action :configure_permited_parameters, if: :devise_controller?

  private
  def configure_permited_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :age, :height, :weight, :bmr, :introduction, :image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :age, :height, :weight, :bmr, :introduction, :image])
  end
end

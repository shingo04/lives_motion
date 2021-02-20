class ApplicationController < ActionController::Base
  before_action :configure_permited_parameters, if: :devise_controller?

  private
  def configure_permited_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :gender_id, :age, :height, :weight, :introduction, :image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :gender_id, :age, :height, :weight, :introduction, :image])
  end
end

class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_q

  protected

  #deveisで許可されていないからnicknameを許可してあげないといけない
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname])
  end

  private

  def set_q
    @q = Place.ransack(params[:q])
  end
end

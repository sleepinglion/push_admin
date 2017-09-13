class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :layout
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end

  def current_ability
      @current_ability ||= UserAbility.new(current_user)
  end

  def layout
    if params[:no_layout]
      return false
    else
      return 'application'
    end
  end
end

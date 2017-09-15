class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :layout
  before_action :set_locale

  def initialize(*params)
    super(*params)
    before_init
  end

  def before_init
    @meta_robot='all, index, follow'
    @meta_description=t(:meta_description)
    @meta_keywords=t(:meta_keywords)
    @meta_image=t(:meta_image)
    @meta_url=t(:meta_url)

    @page_itemtype="http://schema.org/WebPage"
    @resource ||= User.new
  end    

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

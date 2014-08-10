class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :signed_in?

  before_action :set_locale
 
  def set_locale
  	case request.host
  	when "ctfi.cc", "ctfi.dev"
  		I18n.locale = "en-CTFI";
  	else 
  		I18n.locale = I18n.default_locale;
  	end
  end

  def user_required
    redirect_to '/auth/twitter?force_login=true' unless signed_in?
  end

  def signed_in?
    session[:username].present?
  end
end

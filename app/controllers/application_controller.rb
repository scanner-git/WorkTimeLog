class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_month


  private 

  def set_month
  	if params[:work_month]
			@mon = params[:work_month].to_date 
		else
			@mon = Date.today
		end
  end

  def default_url_options(options={})
    { work_month: @mon }
  end


  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def user_signed_in?
    current_user.present?
  end
#  def locale_path(locale)
#    locale_regexp = %r{/(en|de)/?}
#    if request.env['PATH_INFO'] =~ locale_regexp
#      "#{request.env['PATH_INFO']}".gsub(locale_regexp, "/#{locale}/")
#    else
#      "/#{locale}#{request.env['PATH_INFO']}"
#    end
#  end
  helper_method :user_signed_in?
end

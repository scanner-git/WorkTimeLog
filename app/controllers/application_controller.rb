class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_work_month


  private

  def set_work_month
    @time = params[:work_month]
  end

  def dafault_url_options(options={})
  	{work_month: Date.today}
  end
end

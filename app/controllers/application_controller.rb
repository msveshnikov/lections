class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :mobile_device?, :android_device?, :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def check_for_mobile
    session[:mobile_override] = params[:mobile] if params[:mobile]
    prepare_for_mobile if mobile_device?
  end

  def prepare_for_mobile
    prepend_view_path Rails.root + 'app' + 'views_mobile'
  end

  def mobile_device?
    if session[:mobile_override]
      (session[:mobile_override] == '1') || (session[:mobile_override] == '2')
    else
      (request.user_agent =~ /Mobile|webOS|Android/)
    end
  end

  def android_device?
    (session[:mobile_override] == '2')
  end

  def page(a)
    # return a if mobile_device?
    a.paginate(page: params[:page], per_page: mobile_device? ? 200 : 50)
  end
end
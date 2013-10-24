class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def index
    render text: "This is just an API"
  end
  

  protected

  def configure_permitted_parameters
     devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :email) }
     devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
     devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end  

  def logged_in_user_belongs_to_organization!
    rv = true
    organization_id = params[:organization_id]
    #organization_id ||= session[:organization_id]
    organization_id ||= current_user.current_organization.id
    if organization_id.nil?
      render :status=>400, :json=> {:errors=>"missing organization_id parameter"}.to_json
      rv = false
    elsif current_user.organizations.any? {|u| u.id == organization_id.to_i}
      session[:organization_id] = organization_id
      current_user.current_organization = Organization.find organization_id
      @organization_id = organization_id
    else
      puts "user is not part of organization: #{organization_id}"
      render :status=>403, :json=> {:errors=>"you don't have access to this organization"}.to_json
      rv = false
    end
    rv
  end

end

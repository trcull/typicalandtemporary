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

  def site_account_belongs_to_logged_in_user!
    rv = true
    @site_account = SiteAccount.find params[:site_account_id]
    if @site_account.nil?
      puts "site account not found: #{params[:site_account_id]}"
      render :status=>404, :json=> {:errors=>"account not found: #{params[:site_account_id]}"}.to_json
      rv = false
    end
    if @site_account.user.id != current_user.id
      puts "site account doesn't belong to user: #{params[:site_account_id]}"
      render :status=>403, :json=> {:errors=>"you don't have access to this account"}.to_json
      rv = false
    end
    rv
  end

  def logged_in_user_belongs_to_organization!
    rv = true
    organization_id = params[:organization_id]
    organization_id ||= session[:organization_id]
    puts current_user.inspect
    puts current_user.organizations.inspect
    if organization_id.nil?
      render :status=>400, :json=> {:errors=>"missing organization_id parameter"}.to_json
      rv = false
    elsif current_user.organizations.any? {|u| u.id == organization_id.to_i}
      session[:organization_id] = organization_id
      @organization_id = organization_id
    else
      puts "user is not part of organization: #{organization_id}"
      render :status=>403, :json=> {:errors=>"you don't have access to this organization"}.to_json
      rv = false
    end
    rv
  end

end

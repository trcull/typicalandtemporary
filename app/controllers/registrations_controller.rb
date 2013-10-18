# inspired by: http://jessehowarth.com/2011/04/27/ajax-login-with-devise
# used to log in via ajax.  But doesn't replace the normal devise controller for normal logins
class RegistrationsController < Devise::RegistrationsController
  
  # POST /resource
  def create
    if request.xhr?
      build_resource
      if resource.save
        #NewUserMailerScheduler.enqueue(resource)
        if resource.active_for_authentication?
          sign_in(resource_name, resource)
          render :json=>{:id=>resource.id, :email=>resource.email, :remaining_points=>resource.remaining_points, :plan_points=>resource.plan_points}
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
          expire_session_data_after_sign_in!
          render :json=>{:id=>resource.id, :email=>resource.email, :remaining_points=>resource.remaining_points, :plan_points=>resource.plan_points}
        end
      else
        clean_up_passwords resource
        render :json=>{:errors=>resource.errors,:id=>resource.id, :email=>resource.email, :remaining_points=>resource.remaining_points, :plan_points=>resource.plan_points}
      end
    else
      super
      #NewUserMailerScheduler.enqueue(resource) if resource.present? && resource.id.present?
    end
  end  
  
  def update
    super
    current_user.update_on_login
  end
end
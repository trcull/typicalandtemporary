
class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    
  def current_organization
    c = Organization.new 
    c.name = 'fake'
    c.admin_user_id = 1
    c 
  end
  
  #convenience method for showing what we commonly want to show in logs for a user
  def to_log
    "#{id}/#{email}"
  end
  
  
end

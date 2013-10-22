
class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    
  has_many :user_organizations
  has_many :organizations, :through=>:user_organizations

  def current_organization
    self.organizations.first
  end
  
  #convenience method for showing what we commonly want to show in logs for a user
  def to_log
    "#{id}/#{email}"
  end
  
  
end

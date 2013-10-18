
class Organization < ActiveRecord::Base
  belongs_to :admin_user, :foreign_key=>'admin_user_id', :class_name=>"User"
end
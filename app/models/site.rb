class Site < ActiveRecord::Base
  
  #convenience method for showing what we commonly want to show in logs for a user
  def to_log
    "#{id}/#{name}"
  end
  
end

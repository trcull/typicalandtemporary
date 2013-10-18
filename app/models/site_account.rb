class SiteAccount < ActiveRecord::Base
  belongs_to :site
  belongs_to :user
  belongs_to :organization
  
  attr_encrypted :token, :key=>ENV['DATA_ENCRYPT_KEY']
  attr_encrypted :secret, :key=>ENV['DATA_ENCRYPT_KEY']
  attr_encrypted :field1, :key=>ENV['DATA_ENCRYPT_KEY']
  attr_encrypted :field2, :key=>ENV['DATA_ENCRYPT_KEY']
  attr_encrypted :field3, :key=>ENV['DATA_ENCRYPT_KEY']
  attr_encrypted :field4, :key=>ENV['DATA_ENCRYPT_KEY']
  attr_encrypted :field5, :key=>ENV['DATA_ENCRYPT_KEY']

  def active?
    token.present?
  end
  
  def to_log
    "#{id}/#{user.email}"
  end
end

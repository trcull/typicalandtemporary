
class Order < ActiveRecord::Base
  belongs_to :product
  belongs_to :organization
  belongs_to :customer
end
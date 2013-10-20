
class Order < ActiveRecord::Base
  belongs_to :organization
  belongs_to :customer
  has_many :order_lines
end
#see: https://github.com/rails-api/active_model_serializers
class OrderSerializer < ActiveModel::Serializer
  attributes :id, :org_id, :subtotal, :total, :org_created_at, :created_at, :updated_at
  has_one :organization, :customer
end

class ProductSerializer < ActiveModel::Serializer
  attributes :id, :org_id, :name, :created_at, :updated_at, :org_created_at
  has_one :organization
end
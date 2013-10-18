
class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :org_id, :created_at, :updated_at
  has_one :organization
end
require 'spec_helper'

describe Api::V1::OrdersController do
  login_integration
  
  it "doesn't explode" do
    order = FactoryGirl.attributes_for(:order)
    order[:customer] = {
      :org_id => generate(:org_id)
    }
    post "/api/v1/orders", order.to_json, json_headers
  end
end

require 'spec_helper'

describe Api::V1::RollupsController do
  login_integration
  
  it "doesn't explode" do
    puts @user.organizations.inspect
    get "/api/v1/rollups/#{@user.current_organization.id}/order_counts_by_customer_age"
    response.code.should eq "200"
    parsed = JSON.parse response.body
    puts parsed.inspect
    parsed[:errors].should be_nil
  end

  it "doesn't explode" do
#    get "/api/v1/rollups/#{@user.current_organization.id}/order_counts_by_customer_age"
    get "/api/v1/rollups/#{@user.current_organization.id}/order_count_histogram"
    parsed = JSON.parse response.body
    response.code.should eq "200"
    puts parsed.inspect
    parsed[:errors].should be_nil
  end

  it "doesn't explode" do
    get "/api/v1/rollups/#{@user.current_organization.id}/age_at_repeat_order_histogram"
    parsed = JSON.parse response.body
    response.code.should eq "200"
    puts parsed.inspect
    parsed[:errors].should be_nil
  end

end
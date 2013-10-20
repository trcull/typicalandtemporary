
class Api::V1::OrdersController < Api::V1::ApiController
  # POST /orders
  def create
    rv = Order.new
    rv.org_id = params[:org_id]
    rv.org_created_at = params[:org_created_at]
    rv.organization = current_user.current_organization
    
    rv.customer = Customer.find_or_initialize_by(:organization_id=> rv.organization.id, :org_id=>params[:customer][:org_id]) do |c|
      c.organization = rv.organization
      c.email = params[:customer][:email]
      c.mobile_number = params[:customer][:mobile_number]
      c.org_id = params[:customer][:org_id]
    end
    


    #TODO look for order line items, too
    # product = Product.find_or_initialize_by(:organization_id=> rv.organization.id, :org_id=>params[:product][:org_id]) do |p|
      # p.organization = rv.organization
      # p.org_id = params[:product][:org_id]
      # p.name = params[:product][:name] || "Unknown Product"
      # p.org_created_at = params[:product][:org_created_at] || Time.now
    # end


    #TODO calculate from order line items
    rv.subtotal = 0
    rv.total = 0
    
    
    if rv.save
      render json: rv
    else
      render json: rv.errors, status: :unprocessable_entity
    end
  end
end
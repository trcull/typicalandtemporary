require 'csv'

class Import::CsvImporter < Import::AbstractImporter
  def init_column_names()
    #rafter
    # @column_names = {
      # 'id'=>:order_org_id,
      # 'customer_id'=>:customer_org_id,
      # 'created_at'=>:order_org_created_at,
      # 'isbn'=>:product_org_id,
      # 'product_id'=>:product_org_id,
      # 'price'=>:item_price,
      # 'email'=>:customer_email,
      # 'date_created'=>:customer_org_created_at
    # }

    #slideshop
    @column_names = {
      'order_id'=>:order_org_id,
      'cust_id'=>:customer_org_id,
      'order_date'=>:order_org_created_at,
      'product_id'=>:product_org_id,
      'price'=>:item_price,
      'quantity' => :item_qty,
      'email'=>:customer_email,
      'cust_date'=>:customer_org_created_at,
      'customer_age'=>:customer_age
    }


  end
end
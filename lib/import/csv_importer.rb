require 'csv'

class Import::CsvImporter < Import::AbstractImporter
  def init_column_names()
    @column_names = {
      'id'=>:order_org_id,
      'customer_id'=>:customer_org_id,
      'created_at'=>:order_org_created_at,
      'isbn'=>:product_org_id,
      'product_id'=>:product_org_id,
      'price'=>:item_price,
      'email'=>:customer_email,
      'date_created'=>:customer_org_created_at
    }
  end
end
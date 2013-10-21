require 'csv'

class Import::QuickbooksImporter < Import::AbstractImporter
  def init_column_names()
    @column_names = {
      'Num'=>:order_org_id,
      'Cust id'=>:customer_org_id,
      'Date'=>:order_org_created_at,
      'Prod id'=>:product_org_id,
      'Amount'=>:item_price,
    }
  end
  
  def time_format
    "%m/%d/%Y"
  end
  
  def encoding
    'windows-1251:utf-8'
  end
end
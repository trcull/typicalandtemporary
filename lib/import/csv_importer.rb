require 'csv'

class Import::CsvImporter
  def initialize(organization)
    @organization = organization
    @columns = {
      :order_org_id=>[-1,nil],
      :customer_org_id=>[-1,nil],
      :order_org_created_at=>[-1, Time.now.strftime("%Y-%m-%d %H:%M:%S")],
      :product_org_id=>[-1,nil],
      :product_name=>[-1,'unk'],
      :product_org_created_at=>[-1,Time.now.strftime("%Y-%m-%d %H:%M:%S")],
      :item_price=>[-1,0],
      :customer_email=>[-1,'unk'],
      :customer_org_created_at=>[-1,Time.now.strftime("%Y-%m-%d %H:%M:%S")],
      :order_total=>[-1,0],
      :order_subtotal=>[-1,0],
      :item_qty=>[-1,1]
    }
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
  
  def import(file_path)
    i= 0
    CSV.foreach(file_path) do |row|
      if i==0
        scan_for_column_indexes row
      else
        load_row row
      end
      i=i+1
    end
  end
  
  def scan_for_column_indexes(row)
    row.each_with_index do |val, i|
      key = @column_names[val]
      @columns[key][0] = i if key.present?
    end  
    puts @columns.inspect
  end
  
  def v(row, key)
    index = @columns[key][0]
    if index ==-1
      rv = @columns[key][1]
    else
      rv = row[index]
    end  
    rv
  end
  
  def dt(row, key)
    s=v(row,key)
    if s.nil?
      rv = nil
    else
      rv = Time.strptime(s, "%Y-%m-%d %H:%M:%S")
    end 
    rv 
  end
  
  def load_row(row)
    rv = Order.find_or_initialize_by(:organization_id=>@organization.id, :org_id=>v(row,:order_org_id)) do |rv|
      rv.org_id = v(row, :order_org_id)
      rv.organization = @organization
      rv.org_created_at = dt(row, :order_org_created_at)
      rv.customer = Customer.find_or_initialize_by(:organization_id=> @organization.id, :org_id=>v(row,:customer_org_id)) do |c|
        c.organization = @organization
        c.email = v(row,:customer_email)
        c.org_id = v(row,:customer_org_id)
        c.org_created_at = dt(row,:customer_org_created_at)
      end
      
      #TODO calculate from order line items
      rv.subtotal = v(row, :order_subtotal)
      rv.total = v(row,:order_total)
    end
    product = Product.find_or_initialize_by(:organization_id=> @organization.id, :org_id=>v(row,:product_org_id)) do |p|
      p.organization = @organization
      p.org_id = v(row,:product_org_id)
      p.name = v(row,:product_name)
      p.org_created_at = dt(row,:product_org_created_at)
      p.save!
    end
      
    line = rv.order_lines.select {|l| l.product_id == product.id}.first
    if line.nil?
      line = OrderLine.new
      line.quantity = v(row, :item_qty)
      line.price = v(row, :item_price)
      line.product = product
      line.order = rv
      line.save!
      rv.order_lines << line
    end
    rv.save!
  end
end
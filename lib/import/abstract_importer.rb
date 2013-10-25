require 'csv'

class Import::AbstractImporter
  def initialize(organization)
    @organization = organization
    @columns = {
      :order_org_id=>[-1,nil],
      :customer_org_id=>[-1,nil],
      :order_org_created_at=>[-1, Time.now],
      :product_org_id=>[-1,nil],
      :product_name=>[-1,'unk'],
      :product_org_created_at=>[-1,Time.now],
      :item_price=>[-1,0],
      :customer_email=>[-1,'unk'],
      :customer_org_created_at=>[-1,nil],
      :customer_age=>[-1,nil],
      :order_total=>[-1,0],
      :order_subtotal=>[-1,0],
      :item_qty=>[-1,1]
    }
    @best_time_format = 0
    init_column_names
  end

  def self.new_importer(uploaded_file, organization)
    file_type = guess_file_type(uploaded_file)
    if file_type == 'csv'
      rv = Import::CsvImporter.new(organization)
    elsif file_type == 'xlsx' || file_type == 'xls'
      rv = Import::ExcelImporter.new(organization) 
    end 
    rv
  end
  
  def self.guess_file_type(uploaded_file)
    rv = nil
    file_name = uploaded_file.original_filename
    Rails.logger.info "guessing file type of file #{file_name} and content type #{uploaded_file.content_type}"
    if file_name.match /\.xls$/
      rv = 'xls'
    elsif file_name.match /\.csv$/
      rv = 'csv'
    elsif file_name.match /\.xlsx$/
      rv = 'xlsx'
    else
      Rails.logger.info "couldn't guess based on file name, so guessing based on content type "
      # try to guess based on the mime type
      if uploaded_file.content_type.match /application\/vnd\.ms-excel/
        rv = 'xls'
      elsif uploaded_file.content_type.match /application\/vnd.openxmlformats-officedocument\.spreadsheetml\.sheet/
        rv = 'xlsx'
      end
    end
    #just default if we haven't figured it out.
    rv ||= 'xlsx'
    rv
  end

  def time_formats
    ["%Y-%m-%d %H:%M:%S", "%m/%d/%y"]
  end
  
  def init_column_names()
    @column_names = {
      'id'=>:order_org_id,
      'order_id'=>:order_org_id,
      'customer_id'=>:customer_org_id,
      'cust_id'=>:customer_org_id,
      'created_at'=>:order_org_created_at,
      'order_date'=>:order_org_created_at,
      'isbn'=>:product_org_id,
      'product_id'=>:product_org_id,
      'price'=>:item_price,
      'quantity' => :item_qty,
      'email'=>:customer_email,
      'cust_date'=>:customer_org_created_at,
      'date_created'=>:customer_org_created_at,
      'customer_age'=>:customer_age,
      'Num'=>:order_org_id,
      'Cust id'=>:customer_org_id,
      'Date'=>:order_org_created_at,
      'Prod id'=>:product_org_id,
      'Amount'=>:item_price
    }
  end

  def scan_for_column_indexes(row)
    row.each_with_index do |val, i|
      key = @column_names[val]
      @columns[key][0] = i if key.present?
    end  
    Rails.logger.info "Detected these column indexes: #{@columns.inspect}"
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
    elsif s.is_a? Time
      rv = s
    else
      while (rv.nil?  && @best_time_format<time_formats.length) do
        begin
          rv = Time.strptime(s, time_formats[@best_time_format])
        rescue
          @best_time_format += 1
        end
      end
    end 
    rv 
  end
  
  def load_row(row)
    #Rails.logger.info "LOADING ROW: #{row.inspect}"
    Order.transaction do 
      order_id = v(row,:order_org_id)
      rv = Order.find_or_initialize_by(:organization_id=>@organization.id, :org_id=>order_id) do |rv|
        rv.org_id = order_id
        rv.organization = @organization
        rv.org_created_at = dt(row, :order_org_created_at)
        rv.customer = Customer.find_or_initialize_by(:organization_id=> @organization.id, :org_id=>v(row,:customer_org_id)) do |c|
          c.organization = @organization
          c.email = v(row,:customer_email)
          c.org_id = v(row,:customer_org_id)
          c.org_created_at = dt(row,:customer_org_created_at)
          c.save!
        end
        
        rv.customer_age = v(row, :customer_age)
        
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
        Rails.logger.info "New Product #{p.org_id}"
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
end
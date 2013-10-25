
class Import::ExcelImporter < Import::AbstractImporter
  def time_format
    #"%Y-%m-%d %H:%M:%S"
    "%m/%d/%y" #lolita girl
  end
  

  def v(row, key)
    rv = super(row, key)
    #excel very "helpfully" converts these identifiers to Floats with a trailing .0 when we really wanted Strings
    if [:order_org_id,:customer_org_id,:product_org_id].include? key
      if rv.is_a?(Float)
        #Rails.logger.info "Converting identifier #{key} to string #{rv} in row #{row.inspect}"
        rv = "%0.0f" % rv
      end
    end
    rv  
  end
  
  
  def import(working, extension)
    spreadsheet = try_parse_spreadsheet(extension, working)        
    sheet = spreadsheet.default_sheet
    i = 0
    if spreadsheet.first_row(sheet) # sheet is not empty
      header_index = find_header_row(spreadsheet, sheet)
      scan_for_column_indexes spreadsheet.row(header_index, sheet)
      header = spreadsheet.row(header_index, sheet)
      (header_index+1).upto(spreadsheet.last_row(sheet)) do |row|
        #TODO: split this up into manageable chunks, cache in redis, and insert in a background job
        row_arr = spreadsheet.row(row, sheet)
        order_id = v(row_arr,:order_org_id)
        #skip any blank rows
        if order_id.present? && (!order_id.is_a?(String) || order_id.length > 0)
          load_row row_arr
        end
        i=i+1
        if i%1000 == 0
          Rails.logger.info "Imported #{i}"
        end
      end # sheet not empty
    end
    Rails.logger.info "Finished importing #{i} orders"
    i
  end

  def try_parse_spreadsheet(extension, working)
    if extension == 'xlsx'
      begin
        # prefixing Excel(x) with Roo:: due to uninitialized constant bug: http://railscasts.com/episodes/396-importing-csv-and-excel?view=comments
        spreadsheet = Roo::Excelx.new working.path
      rescue => e
        msg = "Exception parsing excel file with exception #{e.message}"
        Rails.logger.error msg
        Rails.logger.error e.backtrace.join('\n')
        #try the other one in case we guessed the file format wrong
        spreadsheet = Roo::Excel.new working.path
      end
    else
      begin
        spreadsheet = Roo::Excel.new working.path
      rescue => e
        msg = "Exception parsing excel file with exception #{e.message}"
        Rails.logger.error msg
        Rails.logger.error e.backtrace.join('\n')
        #try the other one in case we guessed the file format wrong
        spreadsheet = Roo::Excelx.new working.path
      end
    end
    spreadsheet
  end
      
  def find_header_row(spreadsheet, sheet)
    header = 1.upto(spreadsheet.last_row(sheet)) do |index|
      row_arr = spreadsheet.row(index,sheet)
      if row_arr[0].present? && @column_names.include?(row_arr[0])
        return index
      end
    end  
  end
end
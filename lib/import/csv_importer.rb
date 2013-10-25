require 'csv'

class Import::CsvImporter < Import::AbstractImporter
  def encoding
    'windows-1251:utf-8'
  end
  
  def import(file_path, extension)
    i= 0
    CSV.foreach(file_path, :encoding => encoding) do |row|
      Rails.logger.info row.inspect
      if i==0
        scan_for_column_indexes row
      else
        load_row row
      end
      i=i+1
      if i%1000 == 0
        Rails.logger.info "Imported #{i}"
      end
    end
    Rails.logger.info "Finished importing #{i} orders"
    i
  end
  
end
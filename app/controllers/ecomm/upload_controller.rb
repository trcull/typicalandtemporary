
class Ecomm::UploadController < ApplicationController
  before_filter :authenticate_user!
  def index
    
  end
  
  def do_upload
    if params[:export_file].nil?
      flash[:error] = "No upload file selected.  Please select an upload file"
      redirect_to '/ecomm/upload'
    else
      uploaded_file = params[:export_file].tempfile
      extension = Import::ExcelImporter.guess_file_type(params[:export_file])
      working = Tempfile.new(['order_upload',".#{extension}"],Rails.root.join('tmp') )
      begin
        working.write params[:export_file].tempfile.read.force_encoding("UTF-8")
        num_imported = Import::AbstractImporter.new_importer(params[:export_file],current_user.current_organization).import(working, extension)
        Batch::DataCleaner.new.perform(current_user.current_organization.id)
      ensure
        working.unlink
      end    
      flash[:notice] = "Finished importing #{num_imported} orders"
      redirect_to '/dashboard'
      
    end
  end
end
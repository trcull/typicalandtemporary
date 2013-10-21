namespace :import do
  namespace :orders do
    task :csv, [:file_path, :organization_id] => [:environment] do |t, args|
      puts "importing orders from #{args.file_path} with organization id #{args.organization_id} "
      organization = Organization.find args.organization_id
      Import::CsvImporter.new(organization).import(args.file_path)
    end

    task :quickbooks, [:file_path, :organization_id] => [:environment] do |t, args|
      puts "importing orders from #{args.file_path} with organization id #{args.organization_id} "
      organization = Organization.find args.organization_id
      Import::QuickbooksImporter.new(organization).import(args.file_path)
    end

  end
end

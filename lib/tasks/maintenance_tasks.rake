namespace :maintenance do
    task :nightly => :environment do |t, args|
      puts "doing nightly maintenance task"
      Batch::Nightly.new.perform
    end
end

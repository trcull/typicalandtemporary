
class Batch::Nightly
  def perform()
    Organization.all.each do |o|
      #TODO call .delay() first
      Batch::DataCleaner.new.perform(o.id)
    end
  end
end
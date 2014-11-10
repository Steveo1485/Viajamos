namespace :importer do
  desc "Import Locations"
  task :locations => :environment do
    if File.exist?(Rails.root + "db/seeds/locations.csv")
      puts "Beginning location importer"
      LocationImporter.new(Rails.root + "tmp/locations.csv").import_locations!
      puts "Location Importer finishd"
    else
      puts "No location csv found to import."
    end
  end
end


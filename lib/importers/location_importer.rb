class LocationImporter
  require 'csv'

  def initialize(csv_file)
    @csv_file = csv_file
  end

  def import_locations!
    CSV.foreach(@csv_file, :encoding => 'windows-1251:utf-8', headers: true) do |row|
      location = Location.new
      location.country_code = row["country"]
      location.state_code = row["region"].gsub(/\d/, "")
      location.city = row["city"]
      location.latitude = row["latitude"]
      location.longitude = row["longitude"]
      location.save
    end
  end
end
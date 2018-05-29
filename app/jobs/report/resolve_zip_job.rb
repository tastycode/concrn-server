class Report::ResolveZipJob < ApplicationJob
  def perform(report_id:)
    report = Report.find(report_id)
    zip = GooglePlacesClient.zip_for(place_id: report.google_place_id)
    report.update_attributes(zip: zip)
  end
end

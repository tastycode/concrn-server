class GooglePlacesClient
  def self.place_details(place_id)
    key = Secrets.google_places_key
    json = Faraday
      .get("https://maps.googleapis.com/maps/api/place/details/json?placeid=#{place_id}&key=#{key}")
      .body
    JSON.parse(json)
  end

  def self.zip_for(place_id:)
    components = place_details(place_id).dig("result", "address_components")
    zip_component = components.find do |component|
      component["types"].include?("postal_code")
    end
    zip_component["short_name"]
  end
end

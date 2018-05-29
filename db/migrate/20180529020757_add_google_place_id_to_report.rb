class AddGooglePlaceIdToReport < ActiveRecord::Migration[5.1]
  def change
    add_column :reports, :google_place_id, :string
  end
end

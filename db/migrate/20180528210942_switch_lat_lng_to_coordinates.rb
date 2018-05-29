class SwitchLatLngToCoordinates < ActiveRecord::Migration[5.1]
  def change
    enable_extension :postgis
    add_column :reports, :coordinates, :point
    Report.update_all("coordinates = POINT(lat, long)")
    remove_column :reports, :lat
    remove_column :reports, :long

    add_column :point_fences, :coordinates, :point
    PointFence.update_all("coordinates = POINT(lat, long)")
    remove_column :point_fences, :lat
    remove_column :point_fences, :long
  end
end

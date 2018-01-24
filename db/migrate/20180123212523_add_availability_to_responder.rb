class AddAvailabilityToResponder < ActiveRecord::Migration[5.1]
  def change
    add_column :responders, :available, :boolean, default: false
    add_column :responders, :lat, :decimal
    add_column :responders, :long, :decimal
  end
end

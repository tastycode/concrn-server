class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.integer :reporter_id
      t.string :device_id
      t.string :phone
      t.boolean :verified, default: false
      t.timestamps
    end
  end
end

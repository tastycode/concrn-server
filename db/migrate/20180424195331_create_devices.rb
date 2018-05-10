class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.string :user_id
      t.string :identifier

      t.timestamps
    end
  end
end

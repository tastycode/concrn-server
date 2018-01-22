class CreateResponders < ActiveRecord::Migration[5.1]
  def change
    create_table :responders do |t|
      t.integer :reporter_id

      t.timestamps
    end
  end
end

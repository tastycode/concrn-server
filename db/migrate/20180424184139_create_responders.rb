class CreateResponders < ActiveRecord::Migration[5.1]
  def change
    create_table :responders do |t|
      t.integer :user_id
      t.boolean :available

      t.timestamps
    end
  end
end

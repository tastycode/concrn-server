class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.integer :report_id
      t.string :from_type
      t.integer :from_id
      t.string :to_type
      t.integer :to_id
      t.string :text
      t.string :handler

      t.timestamps
    end
  end
end

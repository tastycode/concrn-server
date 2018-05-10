class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.decimal :lat
      t.decimal :long
      t.string :address
      t.string :reporter_notes
      t.string :responder_reporter_notes
      t.string :responder_internal_notes
      t.boolean :is_harm_immediate
      t.integer :reporter_id
      t.integer :responder_id

      t.timestamps
    end
  end
end

class CreateReportEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :report_events do |t|
      t.integer :report_id
      t.string :event_type
      t.string :payload

      t.timestamps
    end
  end
end

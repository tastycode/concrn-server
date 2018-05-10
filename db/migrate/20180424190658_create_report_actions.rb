class CreateReportActions < ActiveRecord::Migration[5.1]
  def change
    create_table :report_actions do |t|
      t.integer :report_id
      t.string :action
      t.jsonb :payload

      t.timestamps
    end
  end
end

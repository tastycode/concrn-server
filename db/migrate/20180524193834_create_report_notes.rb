class CreateReportNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :report_notes do |t|
      t.integer :report_id
      t.integer :user_id
      t.string :notes

      t.timestamps
    end
  end
end

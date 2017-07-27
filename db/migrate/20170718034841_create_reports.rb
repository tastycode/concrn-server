class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.string   "name"
      t.integer  "reporter_id"
      t.decimal  "long",               precision: 10, scale: 6
      t.decimal  "lat",                precision: 10, scale: 6
      t.string   "status",             default: "pending"
      t.text     "nature"
      t.string   "age"
      t.string   "gender"
      t.string   "race"
      t.string   "address"
      t.string   "setting"
      t.text     "reporter_feedback"
      t.text     "responder_notes"

      t.string   "neighborhood"
      t.string   "urgency"
      t.string   "zip"
      t.timestamps
    end
  end
end

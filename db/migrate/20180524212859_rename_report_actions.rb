class RenameReportActions < ActiveRecord::Migration[5.1]
  def change
    drop_table :report_events
    rename_table :report_actions, :report_events
    rename_column :report_events, :action, :event_type
  end
end

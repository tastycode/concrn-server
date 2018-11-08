class AddNotifyReporter < ActiveRecord::Migration[5.1]
  def change
    add_column :report_notes, :notify_reporter, :boolean, default: false
  end
end

class AddNextHandlerToReports < ActiveRecord::Migration[5.1]
  def change
    add_column :reports, :next_handler, :string
  end
end

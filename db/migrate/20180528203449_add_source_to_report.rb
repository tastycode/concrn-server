class AddSourceToReport < ActiveRecord::Migration[5.1]
  def change
    add_column :reports, :source, :string
  end
end

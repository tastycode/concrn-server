class AddZipToReport < ActiveRecord::Migration[5.1]
  def change
    add_column :reports, :zip, :string
  end
end

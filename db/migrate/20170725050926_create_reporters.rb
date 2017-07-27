class CreateReporters < ActiveRecord::Migration[5.1]
  def change
    create_table :reporters do |t|
      t.string :phone
      t.string :name

      t.timestamps
    end
  end
end

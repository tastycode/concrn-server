class CreateReporters < ActiveRecord::Migration[5.1]
  def change
    create_table :reporters do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
